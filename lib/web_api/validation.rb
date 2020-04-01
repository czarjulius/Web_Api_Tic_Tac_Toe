
class Validation

    attr_reader :message
    def initialize
        @message =""
    end
    
    def validate_human_player(value)
        return @message = "kindly pass a player field" unless value
        player = value['player'].downcase
        return @message = "Value can't be empty" if player.empty?
        
        unless player == "player1" || player == "player2"
            @message = "Value must be either player1 or player2"
        end
    end
    def validate_computer_player(value)
        return @message = "kindly pass a player field" unless value
        player = value['player'].downcase
        return @message = "Value can't be empty" if player.empty?
        
        unless player == "human" || player == "computer"
            @message = "Value must be either human or computer"
        end
    end

    def validate_move(value)
        return @message = "kindly pass a move field" unless value
        move = value['move']
        return @message = "Value can't be empty" if move == ""
    end

    def validate_move_player(player)
        return @message = "There is no valid player" if player == nil
    end
    def validate_move_opponent(opponent)
        return @message = "There is no valid opponent" if opponent == nil
    end

    def validate_spot(move,possible_move)
        if possible_move.include?(move)
            'fine'
        elsif move >=9
            @message = "Move is out of range"
        else
            @message = "The move spot is taken, play another spot"
        end
    end

    def validate_opponent(value)
        return @message = "kindly pass an opponent field" unless value
        opponent = value['opponent']
        return @message = "Value can't be empty" if opponent.empty?
   
        unless opponent == 'human' || opponent == 'computer'
            @message = "Value must be either human or computer"
        end
    end
end