require "sinatra"
require "game"
require "json"
require_relative "result_render"
require_relative "persist_data"
require_relative "game_output_type"
require_relative "validation"

enable :sessions

class App < Sinatra::Base
  def initialize(app=nil, data=PersistData.new)
    super(app)
    @data = data

  end

  before do
    content_type 'application/json'
    @render = ResultRenderer.new
    @validate = Validation.new
  end

  get '/' do

    @render.render( "Welcome To TicTacToe")

  end

  post '/player' do
    payload = JSON.parse(request.body.read)
    # p payload
    player = payload["player"]
    @validate.validate_player(player)
    player = payload['player']
    @data.add_detail('player',player) 
    @render.render(@data.data['player'])
  end

  post '/move' do
    payload = JSON.parse(request.body.read)
    # validating
    # payload has move
    # move is not taken

    # move is between 0 and 8 inclusinve
    # player is not null
    player = @data.get_detail('player')
    board = @data.get_detail('board')
    play = TicTacToeGame::Play.new(board)
    move = payload["move"]

    @validate.validate_move(move)
    @validate.validate_spot(move, play.possible_moves)
    return @render.render(@validate.message) unless @validate.message.empty?
    toggle = TicTacToeGame::Toggle.new(player)
    game = TicTacToeGame::Game.new(board,player, toggle)
    game.move(move)
    @data.add_detail('player', toggle.current_turn)
    @data.add_detail('board', game.board)
    if game.end?
      game_output = GameOutputType.new.game_over_type(game)
      return@render.render(game_output.game_over(player))
    end
    @render.render(game.board)
  end

  



end 

