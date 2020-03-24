require_relative "../../lib/Web_Api_Tic_Tac_Toe/Web_Api_Tic_Tac_Toe.rb"

describe WebApiTicTacToe::Welcome do
    it "should display welcome" do
        welcome = WebApiTicTacToe::Welcome.new
        expect(welcome.Welcome).to eq("Welcome")
      end
    
end