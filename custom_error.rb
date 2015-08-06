class InvalidMoveError < StandardError

  attr_reader :move

  def initialize(message, move=nil)
    super(message)
    @move = move
  end
end

class InvalidPieceError < StandardError

  attr_reader :piece

  def initialize(message, piece)
    super(message)
    @piece = piece
  end
end

class InvalidInputError < StandardError

  attr_reader :input

  def initialize(message, input)
    super(message)
    @input = input
  end
end
