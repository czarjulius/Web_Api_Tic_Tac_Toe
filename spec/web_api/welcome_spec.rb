require_relative "../../lib/web_api/web_api.rb"
require 'rack/test'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App.new
  end

  it "should display Welcome To TicTacToe" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq("Welcome To TicTacToe")
  end
    
end