class MockUI
  def initialize(input)
    @input = input
  end

  def request_move
    "request_move called"
  end

  def get_game_configuration
    board_side_length = @input.shift
    player_1_type = @input.shift
    player_1_move_signature = @input.shift
    player_2_type = @input.shift
    player_2_move_signature = @input.shift

    { board_side_length: board_side_length.to_i, 
      player_1: { player_type: player_1_type.to_sym, move_signature: player_1_move_signature}, 
      player_2: { player_type: player_2_type.to_sym, move_signature: player_2_move_signature} }
  end

  def get_validated_input(prompt, condition)
    input = @input.shift
    until condition.call(input)
      input = @input.shift
    end
    input
  end
end