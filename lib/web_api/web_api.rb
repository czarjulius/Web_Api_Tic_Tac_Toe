require "sinatra"
require "game"
require "json"
require_relative "result_render"
require_relative "persist_data"
require_relative "game_type"
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
    @toggle = get_toggle
    @player_type = CurrentPlayerType.new
  end

  get '/' do
    @render.render( "Welcome To TicTacToe")
  end

  delete '/play_again' do
    @data.reset_detail
    
  end

  post '/choose_opponent' do
    payload = JSON.parse(request.body.read)

    @validate.validate_opponent(payload)
    
    return @render.render(@validate.message) unless @validate.message.empty?
    opponent = payload['opponent']
    @data.add_detail('opponent',opponent) 
    @render.render(opponent)
  end

  post '/player' do
    payload = JSON.parse(request.body.read)
    opponent = @data.get_detail('opponent')

    if opponent == 'human'
      @validate.validate_human_player(payload)
    elsif opponent == 'computer'
      @validate.validate_computer_player(payload)
    end
    return @render.render(@validate.message) unless @validate.message.empty?
    player = payload['player']
    @data.add_detail('current_player',player) 
    @render.render(player)
  end

  def get_toggle
    opponent = @data.get_detail('opponent')
    if opponent == "human"
     return TicTacToeGame::HumanHumanToggle.new
    end
     return TicTacToeGame::HumanComputerToggle.new
  end


  post '/move' do
    payload = JSON.parse(request.body.read)

    opponent = @data.get_detail('opponent')
    player = @data.get_detail('player')
    current_player = @data.get_detail('current_player')

    @validate.validate_move_player(player)
    @validate.validate_move_opponent(opponent)
    
    board = @data.get_detail('board')
    play = TicTacToeGame::Play.new(board)
    move_position = payload["move"]
    @validate.validate_move(payload)
    @validate.validate_spot(move_position, play.possible_moves) unless current_player == 'computer'
    return @render.render(@validate.message) unless @validate.message.empty?
    toggle = TicTacToeGame::Toggle.new(player)
    game = TicTacToeGame::Game.new(board,player, toggle)

    current_player_type = @player_type.get_player(current_player)
    current_player_type.make_move(game,move_position)
    current_player =  @toggle.current_turn(current_player)

    if game.end?
      game_output = GameOutputType.new.game_over_type(game)
      return@render.render(game_output.game_over(@data.get_detail('current_player')))
    end

    @data.add_detail('player', toggle.current_turn)
    @data.add_detail('board', game.board)
    @data.add_detail('current_player', current_player)
    @render.render(game.board)
  end

end 

