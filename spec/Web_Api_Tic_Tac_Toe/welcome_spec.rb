require_relative "../../lib/Web_Api_Tic_Tac_Toe/Web_Api_Tic_Tac_Toe.rb"
require 'rack/test'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App.new
  end

  it "should display Welcome To TicTacToe" do
    get '/'

    expect(last_response.body).to eq("Welcome To TicTacToe")
  end
    
end