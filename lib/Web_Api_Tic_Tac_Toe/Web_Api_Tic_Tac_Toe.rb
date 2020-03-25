require "sinatra"

  class App < Sinatra::Base
    get '/' do
      "Welcome To TicTacToe"
    end
  end

