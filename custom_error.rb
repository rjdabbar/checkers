class InvalidMoveError < StandardError

  attr_reader :move

  def initialize(message, move=nil)
    super(message)
    @move = move
  end
end
