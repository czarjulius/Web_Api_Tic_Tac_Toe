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
  context"#Welcome" do
    it "should display Welcome To TicTacToe" do
      get '/'
      expected_result = {message: "Welcome To TicTacToe"}.to_json
      expect(last_response).to be_ok
      expect(last_response.body).to eq(expected_result)
    end
  end

  

  context "#move" do
    it "Should return a board with initial move" do
      @persist_data.add_detail('player', 'x')      
      body={move: 0}.to_json
      post('/move', body, { 'CONTENT_TYPE' => 'application/json' })
      expected_result= {message: ["x","-","-","-","-","-","-","-","-"]}.to_json

      expect(last_response).to be_ok
      expect(last_response.body).to eq(expected_result)

    end
    it "Should return the updated board" do
      @persist_data.add_detail('player', 'x')
        body={move: 2}.to_json
        post('/move', body, { 'CONTENT_TYPE' => 'application/json' })

        expected_result= {message: ["-","-","x","-","-","-","-","-","-"]}.to_json

        expect(last_response).to be_ok
        expect(last_response.body).to eq(expected_result)

    end

    it "Should return the updated board for 'o'" do
      @persist_data.add_detail('player', 'o')
      body={move: 2}.to_json
      post('/move', body, { 'CONTENT_TYPE' => 'application/json' })

      expected_result= {message: ["-","-","o","-","-","-","-","-","-"]}.to_json

      expect(last_response).to be_ok
      expect(last_response.body).to eq(expected_result)

    end

  it "Should update the  board after multiple play" do
    @persist_data.add_detail('player', 'o')
    body={move: 2}.to_json
    expected_result= {message: ["-","-","o","-","-","-","-","-","-"]}.to_json
    post('/move', body, { 'CONTENT_TYPE' => 'application/json' })
    expect(last_response).to be_ok
    expect(last_response.body).to eq(expected_result)

    body={move: 1}.to_json
    expected_result= {message: ["-","x","o","-","-","-","-","-","-"]}.to_json
    post('/move', body, { 'CONTENT_TYPE' => 'application/json' })
    expect(last_response).to be_ok
    expect(last_response.body).to eq(expected_result)
  end

  it "Should win a game by player o" do
    @persist_data.add_detail('player', 'o')
    @persist_data.add_detail('board', ["-","-","o","-","o","x","-","-","x"])
    body={move: 6}.to_json
    expected_result= {message: "Player o won the game"}.to_json
    post('/move', body, { 'CONTENT_TYPE' => 'application/json' })
    expect(last_response).to be_ok
    expect(last_response.body).to eq(expected_result)
  end
  it "Should win a game by player x" do
    @persist_data.add_detail('player', 'x')
    @persist_data.add_detail('board', ["-","-","x","-","x","o","-","-","o"])
    body={move: 6}.to_json
    expected_result= {message: "Player x won the game"}.to_json
    post('/move', body, { 'CONTENT_TYPE' => 'application/json' })
    expect(last_response).to be_ok
    expect(last_response.body).to eq(expected_result)
  end
  it "Should end the game in a tie" do
    @persist_data.add_detail('player', 'o')
    @persist_data.add_detail('board', ["o","x","o","x","o","x","x","-","x"])
    body={move: 7}.to_json
    expected_result= {message: "The game ended in a tie"}.to_json
    post('/move', body, { 'CONTENT_TYPE' => 'application/json' })
    expect(last_response).to be_ok
    expect(last_response.body).to eq(expected_result)
  end

  it "Should return an error message that spot is not available" do
    @persist_data.add_detail('player', 'o')
    @persist_data.add_detail('board', ["o","x","o","x","o","x","x","-","x"])
    body={move: 5}.to_json
    expected_result= {message: "The move spot is taken, play another spot"}.to_json
    post('/move', body, { 'CONTENT_TYPE' => 'application/json' })
    expect(last_response).to be_ok
    expect(last_response.body).to eq(expected_result)
  end
end

context "#opponent" do
  it "should display human" do
    body = {opponent: "1" }.to_json
    post('/choose_opponent', body, { 'CONTENT_TYPE' => 'application/json' })
    expected_result = {message: "human"}.to_json
    puts last_response.errors

    expect(last_response).to be_ok
    expect(last_response.body).to eq(expected_result)
  end
end
  
end