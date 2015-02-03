class BeatableAiPlayer
  attr_reader :move_signature

  def initialize(move_signature)
    @move_signature = move_signature
  end

  def get_move(rules)
    prng = Random.new
    move = prng.rand(1..rules.board.size)
    until rules.board.open_spaces.include? move
      move = prng.rand(1..rules.board.size)
    end
    move
  end
end