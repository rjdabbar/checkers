class Piece

  attr_reader :color, :board
  attr_accessor :pos
  
  def initialize(color, pos, board)
    @color, @pos, @board, = color, pos, board
  end

end
