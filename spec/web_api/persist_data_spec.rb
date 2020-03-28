require 'rack/test'
require_relative "../../lib/web_api/persist_data.rb"

RSpec.describe PersistData do
    it "should add a new data to the hash" do
        persist_data = PersistData.new
        expected_result = {:name => "julius"}
        persist_data.add_detail(:name,"julius")
        expect(persist_data.data).to eq(expected_result)
    end

end