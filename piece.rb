require 'colorize'
class Piece
  RED_MOVES =   [[ 1, -1],[ 1, 1]]
  BLACK_MOVES = [[-1, -1],[-1, 1]]
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
