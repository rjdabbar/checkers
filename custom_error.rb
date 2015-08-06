class InvalidMoveError < StandardError

  attr_reader :move

  def initialize(move)
    @move = move
  end
end
