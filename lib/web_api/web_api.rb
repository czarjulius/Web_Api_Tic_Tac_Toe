require "sinatra"
require "game"
require "json"
require_relative "result_render"
require_relative "persist_data"
require_relative "game_output_type"
require_relative "validation"
require_relative "human_computer_toggle"
require_relative "human_human_toggle"

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
    @human_computer_toggle = HumanComputerToggle.new
    @human_human_toggle = HumanHumanToggle.new
  end

  get '/' do
    @render.render( "Welcome To TicTacToe")
  end

  post '/choose_opponent' do
    payload = JSON.parse(request.body.read)

    @validate.validate_opponent(payload)
    
    return @render.render(@validate.message) unless @validate.message.empty?
    opponent = payload['opponent']
    # p "+++++++++++++++++++"
    # p opponent
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

  post '/move' do
    payload = JSON.parse(request.body.read)

    opponent = @data.get_detail('opponent')
    player = @data.get_detail('player')
    current_player = @data.get_detail('current_player')

    @validate.validate_move_player(player)
    @validate.validate_move_opponent(opponent)
    
    board = @data.get_detail('board')
    play = TicTacToeGame::Play.new(board)
    move = payload["move"]
    @validate.validate_move(payload)
    @validate.validate_spot(move, play.possible_moves) unless current_player == 'computer'
    return @render.render(@validate.message) unless @validate.message.empty?
    toggle = TicTacToeGame::Toggle.new(player)
    game = TicTacToeGame::Game.new(board,player, toggle)


    
    if opponent == 'human'
      game.move(move)
      current_player == @human_human_toggle.current_turn(current_player)
    else
      if current_player == 'human'
        game.move(move)
      else
        game.move(game.best_move)
      end
      current_player =  @human_computer_toggle.current_turn(current_player)
    end

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

