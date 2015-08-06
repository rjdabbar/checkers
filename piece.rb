require 'colorize'
class Piece

  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, pos, board)
    @color, @pos, @board, = color, pos, board
    board.add_piece(self)
  end

  def to_s
    print "O".colorize(color)
  end



end
