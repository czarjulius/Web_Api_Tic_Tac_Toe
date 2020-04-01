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
  context"#Player" do
    it "should display player x" do
      @persist_data.add_detail('opponent','human')
      body={player: 'player1'}.to_json
      post('/player', body, { 'CONTENT_TYPE' => 'application/json' })
      expected_result= {message: 'player1'}.to_json

      expect(last_response).to be_ok
      expect(last_response.body).to eq(expected_result)

    end
    it "should display player o" do
      @persist_data.add_detail('opponent','human')
      body={player: 'player2'}.to_json
      post('/player', body, { 'CONTENT_TYPE' => 'application/json' })
      expected_result= {message: 'player2'}.to_json

      expect(last_response).to be_ok
      expect(last_response.body).to eq(expected_result)

    end
    it "should display player human" do
      @persist_data.add_detail('opponent','computer')
      body={player: 'human'}.to_json
      post('/player', body, { 'CONTENT_TYPE' => 'application/json' })
      expected_result= {message: 'human'}.to_json

      expect(last_response).to be_ok
      expect(last_response.body).to eq(expected_result)

    end
    it "should display player computer" do
      @persist_data.add_detail('opponent','computer')
      body={player: 'computer'}.to_json
      post('/player', body, { 'CONTENT_TYPE' => 'application/json' })
      expected_result= {message: 'computer'}.to_json

      expect(last_response).to be_ok
      expect(last_response.body).to eq(expected_result)

    end
  end
end