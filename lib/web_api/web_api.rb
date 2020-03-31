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

  post '/choose_opponent' do
    payload = JSON.parse(request.body.read)

    @validate.validate_opponent(payload)


    opponent = payload['opponent']
    current_opponent = opponent == "1" ? "human" : "computer"
    @data.add_detail('opponent',current_opponent) 

    @render.render(@data.data['opponent'])
  end

  post '/player' do
    payload = JSON.parse(request.body.read)
    @validate.validate_player(payload)
    player = payload['player']
    @data.add_detail('player',player) 
    @render.render(@data.data['player'])
  end

  post '/move' do
    payload = JSON.parse(request.body.read)

    player = @data.get_detail('player')
    @validate.validate_move_player(player)
    
    board = @data.get_detail('board')
    play = TicTacToeGame::Play.new(board)
    move = payload["move"]
    @validate.validate_move(payload)
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

