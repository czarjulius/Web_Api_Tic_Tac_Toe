require_relative "draw_game"
require_relative "win_game"
require_relative "computer_move"
require_relative "human_move"

class GameOutputType
    def game_over_type(game)
        if game.blocked?
          DrawGame.new
        else
          WinGame.new
        end
    end
end

class CurrentPlayerType
  def get_current_player(current_player)
    if current_player == 'human'
      HumanMove.new
    else
      ComputerMove.new
    end
  end
end