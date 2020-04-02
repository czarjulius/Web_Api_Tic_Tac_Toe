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
  context"#Play_Again" do
    it "should reset data to initial state" do
      @persist_data.add_detail('opponent','computer')
      @persist_data.add_detail('player','o')
      delete('/play_again', {}, { 'CONTENT_TYPE' => 'application/json' })
      expected_result= "Data reset to an empty hash"
      puts last_response.errors

      expect(last_response).to be_ok
      expect(last_response.body).to eq(expected_result)

    end
  end
end