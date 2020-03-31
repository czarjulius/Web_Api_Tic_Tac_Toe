require_relative '../../lib/web_api/validation'

RSpec.describe Validation do

    context "#validate_player" do
        it "returns error message when player field is nil" do
            validation = Validation.new
            expected_result = "kindly pass a player field"
            expect(validation.validate_player(nil)).to eq(expected_result)
        end

        it "returns error message when player value is empty" do
            validation = Validation.new
            data  = {"player" => ""}
            expected_result = "Value can't be empty"
            expect(validation.validate_player(data)).to eq(expected_result)
        end

        it "returns error message when player value is not exactly o or x" do
            validation = Validation.new
            data  = {"player" => 'h'}
            expected_result = "Value must be either x or o"
            expect(validation.validate_player(data)).to eq(expected_result)
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


            it "returns error message when move player is empty" do
                validation = Validation.new
                player= nil
                expected_result = "There is no valid player"
                validation.validate_move_player(player)
                expect(validation.message).to eq(expected_result)
            end
        end

    end
end