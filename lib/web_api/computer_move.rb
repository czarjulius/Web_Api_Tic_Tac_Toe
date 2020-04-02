class ComputerMove
    def make_move(game,move=nil)
        game.move(game.best_move)
    end
end