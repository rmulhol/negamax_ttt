class Runner
  attr_reader :user_interface, :rules, :player_1, :player_2

  def initialize(ui, rules, player_1, player_2)
    @user_interface = ui
    @rules = rules
    @player_1 = player_1
    @player_2 = player_2
  end

  def run
    user_interface.describe_board_configuration(rules.board)
    game_loop
  end

  def game_loop
    loop do
      single_game
      play_again = user_interface.play_again?
      rules.board.clear_board
      break unless play_again
    end
  end

  def single_game
    cycle_moves_until_game_over
    winner = find_winner
    user_interface.announce_outcome(winner)
  end

  def cycle_moves_until_game_over
    user_interface.display_board(rules.board)
    [player_1, player_2].cycle do |player|
      move = player.get_move(rules)
      rules.board.place_move(move, player.move_signature)
      user_interface.display_board(rules.board)
      break if rules.game_over?(player_1.move_signature, player_2.move_signature)
    end
  end

  def find_winner
    if rules.player_wins?(player_1.move_signature)
      player_1.move_signature
    elsif rules.player_wins?(player_2.move_signature)
      player_2.move_signature
    else
      :tie
    end
  end
end