require 'rack/test'
require 'json'
require_relative "../../lib/web_api/result_render.rb"

RSpec.describe ResultRenderer do
    it "returns an empty JSON object" do
        json = ResultRenderer.new
        
        expect(json.render("")).to eq({ message: ""}.to_json)
    end

    it "returns name in a JSON object" do
        json = ResultRenderer.new
        
        expect(json.render("name")).to eq({ message: "name"}.to_json)
    end

end