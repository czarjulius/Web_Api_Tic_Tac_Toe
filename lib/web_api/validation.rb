
class Validation

    attr_reader :message
    def initialize
        @message =""
    end
    
    def validate_player(value)
        return @message = "kindly pass a player field" unless value
        player = value['player'].downcase
        return @message = "Value can't be empty" if player.empty?
   
        if player != "x" || player != "o"
            @message = "Value must be either x or o"
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

    def validate_spot(move,possible_move)
        if possible_move.include?(move)
            'fine'
        elsif move >=9
            @message = "Move is out of range"
        else
            @message = "The move spot is taken, play another spot"
        end
    end
end