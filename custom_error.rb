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
