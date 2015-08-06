class InvalidMoveError < StandardError

  attr_reader :move

  def initialize(move=nil)
    @move = move
  end
end
