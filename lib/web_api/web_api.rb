require "sinatra"
require "game"


class App < Sinatra::Base
  get '/' do
    "Welcome To TicTacToe"
  end

  get '/toggle' do
    toggle = TicTacToeGame::Toggle.new("x")
    toggle.other_turn
    toggle.current_turn
  end
end

