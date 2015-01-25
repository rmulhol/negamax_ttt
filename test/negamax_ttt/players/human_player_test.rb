require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent.parent + "lib" + "players" + "human_player.rb"
require Pathname(__dir__).parent + "mocks" + "mock_ui.rb"

class HumanPlayerTest < Minitest::Test

  def generate_human_player_with_input(input)
    cli = MockUI.new(input)
    HumanPlayer.new("X", cli)
  end

  def test_get_move
    human_player_with_valid_input = generate_human_player_with_input(["1"])
    human_player_with_invalid_input = generate_human_player_with_input(["-1", "100", "2"])
    human_player_with_input_for_claimed_spaces = generate_human_player_with_input(["1", "2", "3"])
    
    empty_board = Board.new(3)
    
    board_with_spaces_claimed = Board.new(3)
    board_with_spaces_claimed.place_move(1, "X")
    board_with_spaces_claimed.place_move(2, "O")

    assert_equal 1, human_player_with_valid_input.get_move(empty_board)
    assert_equal 2, human_player_with_invalid_input.get_move(empty_board)
    assert_equal 3, human_player_with_input_for_claimed_spaces.get_move(board_with_spaces_claimed)
  end
end