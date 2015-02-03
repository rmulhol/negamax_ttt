class UnbeatableAiPlayer
  attr_reader :move_signature

  def initialize(move_signature)
    @move_signature = move_signature
  end

  def get_move(rules)
    opponent = get_opponent(rules.board)
    return 1 if opponent == :no_opponent_move

    top_score = -100.0
    move_index = nil

    rules.board.open_spaces.each do |space|
      rules.board.place_move(space, move_signature)
      score = negamax(rules, false, opponent, 100, -100, 1)
      if score > top_score
        top_score = score
        move_index = space
      end
      rules.board.place_move(space, nil)
    end

    move_index
  end

  def negamax(rules, my_turn, opponent, alpha, beta, depth)
    return score_board(rules, opponent) / depth if rules.game_over?(move_signature, opponent)

    rules.board.open_spaces.each do |space|
      my_turn ? rules.board.place_move(space, move_signature) : rules.board.place_move(space, opponent)
      score = -negamax(rules, !my_turn, opponent, -beta, -alpha, depth + 1)
      if score < alpha
        alpha = score
      end
      rules.board.place_move(space, nil)
      break if alpha <= beta
    end

    return alpha
  end

  def score_board(rules, opponent)
    if rules.player_wins?(move_signature) || rules.player_wins?(opponent)
      10.0
    else
      0.0
    end
  end

  def get_opponent(board)
    opponent = board.board.values.select { |val| val != move_signature }.compact.sample || :no_opponent_move
  end
end