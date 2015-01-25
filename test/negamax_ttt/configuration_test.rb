require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent.parent + "lib" + "negamax_ttt" + "configuration.rb"
require Pathname(__dir__).parent.parent + "lib" + "negamax_ttt" + "runner.rb"
require Pathname(__dir__) + "mocks" + "mock_ui.rb"

class ConfigurationTest < Minitest::Test

  def setup
    @config = generate_configuration_with_input
  end

  def generate_configuration_with_input(input = ["gets was called"])
    ui = MockUI.new(input)
    Configuration.new(ui)
  end

  def test_configure_game
    hvh_game_input = ["3", "human_player", "X", "human_player", "O"]
    hvc_game_input = ["4", "human_player", "X", "beatable_ai_player", "O"]
    cvc_game_input = ["5", "beatable_ai_player", "X", "unbeatable_ai_player", "O"]

    hvh_game = generate_configuration_with_input(hvh_game_input).configure_game
    hvc_game = generate_configuration_with_input(hvc_game_input).configure_game
    cvc_game = generate_configuration_with_input(cvc_game_input).configure_game


    assert_instance_of Runner, hvh_game, "configure_game should return a runner"
    assert_instance_of Runner, hvc_game, "configure_game should return a runner"
    assert_instance_of Runner, cvc_game, "configure_game should return a runner"

    assert_instance_of HumanPlayer, hvh_game.player_1, "configure_game should return a runner with a human player as player 1 in a HvH game"
    assert_instance_of HumanPlayer, hvh_game.player_2, "configure_game should return a runner with a human player as player 2 in a HvH game"

    assert_instance_of HumanPlayer, hvc_game.player_1, "configure_game should return a runner with a human player as player 1 in a HvC game"
    assert_instance_of BeatableAiPlayer, hvc_game.player_2, "configure_game should return a runner with an ai player as player 2 in a HvC game"

    assert_instance_of BeatableAiPlayer, cvc_game.player_1, "configure_game should return a runner with an ai player as player 1 in a CvC game"
    assert_instance_of UnbeatableAiPlayer, cvc_game.player_2, "configure_game should return a runner with an ai player as player 2 in a CvC game"

    assert_equal 3, hvh_game.board.side_length, "configure_game should return a runner with a 3x3 board if :board_side_length is 3"
    assert_equal 4, hvc_game.board.side_length, "configure_game should return a runner with a 4x4 board if :board_side_length is 4"
    assert_equal 5, cvc_game.board.side_length, "configure_game should return a runner with a 5x5 board if :board_side_length is 5"
  end

  def test_player
    human_player_settings =  { player_type: :human_player, move_signature: "X" }
    beatable_ai_player_settings = { player_type: :beatable_ai_player, move_signature: "X" }
    unbeatable_ai_player_settings = { player_type: :unbeatable_ai_player, move_signature: "X" }

    assert_instance_of HumanPlayer, @config.player(human_player_settings), "player should return a human player if :player_type is :human_player"
    assert_instance_of BeatableAiPlayer, @config.player(beatable_ai_player_settings), "player should return a beatable ai player if :player_type is :beatable_ai_player"
    assert_instance_of UnbeatableAiPlayer, @config.player(unbeatable_ai_player_settings), "player should return an unbeatable ai player if :player_type is :unbeatable_ai_player"
  end

  def test_human_player
    assert_instance_of HumanPlayer, @config.human_player("X"), "human_player should return a new instance of HumanPlayer"
  end

  def test_beatable_ai_player
    assert_instance_of BeatableAiPlayer, @config.beatable_ai_player("X"), "beatable_ai_player should return a new instance of BeatableAiPlayer"
  end

  def test_unbeatable_ai_player
    assert_instance_of UnbeatableAiPlayer, @config.unbeatable_ai_player("X"), "unbeatable_ai_player should return a new instance of UnbeatableAiPlayer"
  end
end