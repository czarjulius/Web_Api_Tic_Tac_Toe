require_relative "draw_game"
require_relative "win_game"

class GameOutputType
    def game_over_type(game)
        if game.blocked?
          DrawGame.new
        else
          WinGame.new
        end
    end
end