class Rules
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def game_over?(player_1_move_signature, player_2_move_signature)
    board.open_spaces.empty? || player_wins?(player_1_move_signature) || player_wins?(player_2_move_signature)
  end

  def player_wins?(move_signature)
    winning_combinations.any? do |winning_combination|
      board.board.select do |key, value|
        winning_combination.include?(key) && value == move_signature
      end
      .length == board.side_length
    end
  end

  def winning_combinations
    board.rows + board.columns + board.diagonals
  end
end