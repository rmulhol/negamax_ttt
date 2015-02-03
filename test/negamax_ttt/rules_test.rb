require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent.parent + "lib" + "negamax_ttt" + "rules.rb"
require Pathname(__dir__).parent.parent + "lib" + "negamax_ttt" + "board.rb"

class RulesTest < Minitest::Test

  def setup
    @board_3x3 = Board.new(3)
    @board_4x4 = Board.new(4)
    @rules_3x3 = Rules.new(@board_3x3)
    @rules_4x4 = Rules.new(@board_4x4)
  end

  def test_game_over
    claim_all_spaces(@board_3x3)
    claim_all_spaces(@board_4x4)

    assert @rules_3x3.game_over?("X", "O"), "game_over? should return true if all spaces claimed on a 3x3 board"
    assert @rules_4x4.game_over?("X", "O"), "game_over? should return true if all spaces claimed on a 4x4 board"

    @board_3x3.clear_board
    @board_4x4.clear_board

    claim_row(@board_3x3, "X")
    claim_row(@board_4x4, "O")

    assert @rules_3x3.game_over?("X", "O"), "game_over? should return true if player wins on 3x3 board"
    assert @rules_4x4.game_over?("X", "O"), "game_over? should return true if player wins on 4x4 board"
  end


  def claim_all_spaces(board)
    (1..board.size).each do |key|
      board.place_move(key, "X")
    end
  end

  def test_player_wins
    assert !@rules_3x3.player_wins?("X"), "player wins should return false if no spaces claimed on a 3x3 board"
    assert !@rules_4x4.player_wins?("O"), "player_wins should return false if no spaces claimed on a 4x4 board"

    claim_row(@board_3x3, "X")
    claim_row(@board_4x4, "O")
    
    assert @rules_3x3.player_wins?("X"), "player_wins should return true if X is placed on every space in a row on a 3x3 board"
    assert @rules_4x4.player_wins?("O"), "player_wins should return true if O is places on every space in a row on a 4x4 board"
    
    @board_3x3.clear_board
    @board_4x4.clear_board

    claim_column(@board_3x3, "X")
    claim_column(@board_4x4, "O")

    assert @rules_3x3.player_wins?("X"), "player_wins should return true if X is placed on every space in a column on a 3x3 board"
    assert @rules_4x4.player_wins?("O"), "player_wins should return true if O is places on every space in a column on a 4x4 board"

    @board_3x3.clear_board
    @board_4x4.clear_board

    claim_diagonal(@board_3x3, "X")
    claim_diagonal(@board_4x4, "O")

    assert @rules_3x3.player_wins?("X"), "player_wins should return true if X is placed on every space in a diagonal on a 3x3 board"
    assert @rules_4x4.player_wins?("O"), "player_wins should return true if O is placed on every space in a diagonal on a 4x4 board"
  end

  def claim_row(board, move_signature)
    (1..board.side_length).each do |key|
      board.place_move(key, move_signature)
    end
  end

  def claim_column(board, move_signature)
    board.column_starting_at(1).each do |key|
      board.place_move(key, move_signature)
    end
  end

  def claim_diagonal(board, move_signature)
    board.left_to_right_diagonal.each do |key|
      board.place_move(key, move_signature)
    end
  end

  def test_winning_combinations
    winning_combinations_3x3 = [[1, 2, 3,], [4, 5, 6], [7, 8, 9],
                                [1, 4, 7], [2, 5, 8], [3, 6, 9],
                                [1, 5, 9], [3, 5, 7]]
    winning_combinations_4x4 = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16],
                                [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [4, 8, 12, 16],
                                [1, 6, 11, 16], [4, 7, 10, 13]]

    assert_equal winning_combinations_3x3, @rules_3x3.winning_combinations, "winning_combinations should return all winning combinations for a 3x3 board"
    assert_equal winning_combinations_4x4, @rules_4x4.winning_combinations, "winning_combinations should return all winning combinations for a 4x4 board"
  end
end