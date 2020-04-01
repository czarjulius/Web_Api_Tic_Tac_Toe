require_relative "../../lib/web_api/human_computer_toggle"

RSpec.describe HumanComputerToggle do
  before(:each) do
    @toggle = HumanComputerToggle.new
  end

  context "#current_turn" do 
  it "Should toggle from human to computer" do
    expect(@toggle.current_turn('human')).to eq('computer')
  end
  it "Should toggle from computer to human" do
    expect(@toggle.current_turn('computer')).to eq('human')
  end
 end
end