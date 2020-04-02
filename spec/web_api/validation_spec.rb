require_relative '../../lib/web_api/validation'

RSpec.describe Validation do

    context "#validate_human_player" do
        it "returns error message when player field is nil" do
            validation = Validation.new
            expected_result = "kindly pass a player field"
            expect(validation.validate_human_player(nil)).to eq(expected_result)
        end

        it "returns error message when player value is empty" do
            validation = Validation.new
            data  = {"player" => ""}
            expected_result = "Value can't be empty"
            expect(validation.validate_human_player(data)).to eq(expected_result)
        end

        it "returns error message when player value is not exactly player1 or player2" do
            validation = Validation.new
            data  = {"player" => 'h'}
            expected_result = "Value must be either player1 or player2"
            expect(validation.validate_human_player(data)).to eq(expected_result)
        end    
    end


    context "#validate_computer_player" do
        it "returns error message when player field is nil" do
            validation = Validation.new
            expected_result = "kindly pass a player field"
            expect(validation.validate_computer_player(nil)).to eq(expected_result)
        end

        it "returns error message when player value is empty" do
            validation = Validation.new
            data  = {"player" => ""}
            expected_result = "Value can't be empty"
            expect(validation.validate_computer_player(data)).to eq(expected_result)
        end

        it "returns error message when player value is not exactly human or computer" do
            validation = Validation.new
            data  = {"player" => 'h'}
            expected_result = "Value must be either human or computer"
            expect(validation.validate_computer_player(data)).to eq(expected_result)
        end    
    end

    context "#validate_move" do
        it "returns error message when move field is nil" do
            validation = Validation.new
            expected_result = "kindly pass a move field"
            expect(validation.validate_move(nil)).to eq(expected_result)
        end
        it "returns error message when move value is empty" do
            validation = Validation.new
            data  = {"move" => ""}
            expected_result = "Value can't be empty"
            expect(validation.validate_move(data)).to eq(expected_result)
        end
        it "returns error message when move value is not an integer" do
            validation = Validation.new
            data  = {"move" => "b"}
            expected_result = "Value must be an integer"
            expect(validation.validate_move(data)).to eq(expected_result)
        end

        
    context "#validate_spot" do
        it "returns empty message when move is available" do
            validation = Validation.new
            move= 3
            possible_moves = [3]
            expected_result = ""
            validation.validate_spot(move,possible_moves)
            expect(validation.message).to eq(expected_result)
        end

        it "returns error message when move spot is taken" do
            validation = Validation.new
            move= 3
            possible_moves = [1]
            expected_result = "The move spot is taken, play another spot"
            validation.validate_spot(move,possible_moves)
            expect(validation.message).to eq(expected_result)
        end
        it "returns error message when move spot is greater than 8" do
            validation = Validation.new
            move= 33
            possible_moves = [1]
            expected_result = "Move is out of range"
            validation.validate_spot(move,possible_moves)
            expect(validation.message).to eq(expected_result)
        end
    end

    context "#validate_move_player" do
        it "returns error message when move player is empty" do
            validation = Validation.new
            player= nil
            expected_result = "There is no valid player"
            validation.validate_move_player(player)
            expect(validation.message).to eq(expected_result)
        end
    end

    context "#validate_move_opponent" do
        it "returns error message when move opponent is empty" do
            validation = Validation.new
            opponent= nil
            expected_result = "There is no valid opponent"
            validation.validate_move_opponent(opponent)
            expect(validation.message).to eq(expected_result)
        end
    end

    end
    context "#opponent" do
        it "returns error message when opponent field is nil" do
            validation = Validation.new
            expected_result = "kindly pass an opponent field"
            expect(validation.validate_opponent(nil)).to eq(expected_result)
        end

        it "returns error message when opponent value is empty" do
            validation = Validation.new
            data  = {"opponent" => ""}
            expected_result = "Value can't be empty"
            expect(validation.validate_opponent(data)).to eq(expected_result)
        end

        it "returns error message when opponent value is not exactly human or computer" do
            validation = Validation.new
            data  = {"opponent" => '5'}
            expected_result = "Value must be either human or computer"
            expect(validation.validate_opponent(data)).to eq(expected_result)
        end    

        it "returns empty message when opponent is human or computer" do
            validation = Validation.new
            data  = {"opponent" => 'human'}
            expected_result = ""
            validation.validate_opponent(data)
            expect(validation.message).to eq(expected_result)
        end    
    end
end