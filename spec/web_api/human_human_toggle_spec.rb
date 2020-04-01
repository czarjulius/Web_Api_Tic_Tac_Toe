require_relative "../../lib/web_api/human_human_toggle"

RSpec.describe HumanHumanToggle do
  before(:each) do
    @toggle = HumanHumanToggle.new
  end

  context "#current_turn" do 
  it "Should toggle from player1 to player2" do
    expect(@toggle.current_turn('player1')).to eq('player2')
  end
  it "Should toggle from player2 to player1" do
    expect(@toggle.current_turn('player2')).to eq('player1')
  end
 end
end