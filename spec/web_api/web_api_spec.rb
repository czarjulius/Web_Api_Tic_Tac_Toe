require_relative "../../lib/web_api/web_api.rb"
require_relative "../../lib/web_api/persist_data.rb"
require 'rack/test'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App.new(nil, @persist_data)
  end
  
  before(:each) do
    @persist_data = PersistData.new
  end

  it "should display Welcome To TicTacToe" do
    get '/'
    expected_result = {message: "Welcome To TicTacToe"}.to_json
    expect(last_response).to be_ok
    expect(last_response.body).to eq(expected_result)
  end

  it "should display human" do
    # post '/choose_opponent'
    body = {opponent: "1" }.to_json
    post('/choose_opponent', body, { 'CONTENT_TYPE' => 'application/json' })
    puts last_response.errors
    expected_result = {message: "human"}.to_json


    expect(last_response).to be_ok
    expect(last_response.body).to eq(expected_result)
  end

  context "#move" do
    it "Should return an initial board" do
      @persist_data.add_detail(:player, 'x')

        body={move: 0}.to_json
        post('/move', body, { 'CONTENT_TYPE' => 'application/json' })


        expected_result= {message: ["x","-","-","-","-","-","-","-","-"]}.to_json

        expect(last_response).to be_ok
        expect(last_response.body).to eq(expected_result)

    end
    it "Should return the updated board" do
      @persist_data.add_detail(:player, 'x')

        body={move: 2}.to_json
        post('/move', body, { 'CONTENT_TYPE' => 'application/json' })

        expected_result= {message: ["-","-","x","-","-","-","-","-","-"]}.to_json

        expect(last_response).to be_ok
        expect(last_response.body).to eq(expected_result)

    end

    it "Should return the updated board for 'o'" do
      # @data['player'] = 'o'
      @persist_data.add_detail(:player, 'o')
      body={move: 2,player: "o"}.to_json
      post('/move', body, { 'CONTENT_TYPE' => 'application/json' })

      expected_result= {message: ["-","-","o","-","-","-","-","-","-"]}.to_json

      expect(last_response).to be_ok
      expect(last_response.body).to eq(expected_result)

  end
end
  
    
end