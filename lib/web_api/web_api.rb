require "sinatra"
require "game"
require "json"
require_relative "result_render"

enable :sessions

class App < Sinatra::Base
  def initialize(app=nil, data={})
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


  post '/choose_opponent' do
    payload = JSON.parse(request.body.read)
    opponent = payload['opponent']
    
    @data['opponent'] = opponent == "1" ? "human" : "computer"

    @render.render(@data['opponent'])
  end

  post '/player' do
    payload = JSON.parse(request.body.read)
    player = payload['player']
    @data['player'] = player
    @render.render(@data['player'])
  end

  post '/move' do
    payload = JSON.parse(request.body.read)
    move = payload["move"]
    game = TicTacToeGame::Game.new.move(move)
    @render.render(game.board)
  end















  # get '/toggle' do
  #   toggle = TicTacToeGame::Toggle.new("x")
  #   toggle.other_turn
  #   toggle.current_turn
  # end
end 

