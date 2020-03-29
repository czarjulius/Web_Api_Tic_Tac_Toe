require "sinatra"
require "game"
require "json"
require_relative "result_render"
require_relative "persist_data"

enable :sessions

class App < Sinatra::Base
  def initialize(app=nil, data=PersistData.new)
    super(app)
    @data = data

  end

  before do
    content_type 'application/json'
    @render = ResultRenderer.new
  end

  get '/' do

    @render.render( "Welcome To TicTacToe")

  end



  post '/player' do

    payload = JSON.parse(request.body.read)
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
    move = payload["move"]
    player = @data.get_detail('player')
    board = @data.get_detail('board')
    toggle = TicTacToeGame::Toggle.new(player)
    game = TicTacToeGame::Game.new(board,player, toggle)
    game.move(move)
    @data.add_detail('player', toggle.current_turn)
    @data.add_detail('board', game.board)
    if game.end?
      if game.blocked?
        return @render.render("The game ended in a tie")
      else
        return @render.render("Player #{player} won the game")
      end
    end
    @render.render(game.board)
  end


end 

