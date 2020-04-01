class HumanComputerToggle
    attr_reader :current_player
    def current_turn(current_player)
        current_player == "human" ? "computer" : "human"                               
    end
end