require 'colorize'
class Piece
  RED_MOVES =   [[ 1, -1],[ 1, 1]]
  BLACK_MOVES = [[-1, -1],[-1, 1]]
  attr_reader :color, :board
  attr_accessor :pos, :rank

  def initialize(color, pos, board)
    @color, @pos, @board, = color, pos, board
    @rank = :pawn
    board.add_piece(self)
  end

  def to_s
    print "O".colorize(color)
  end

  def move_dirs
    color == :red ? RED_MOVES : BLACK_MOVES
  end

  def moves
    moves = []
      move_dirs.each do |direction|
        potential_move = new_pos(pos, direction)
        moves << potential_move if board.empty?(potential_move)
      end

    moves
  end

  def new_pos(start_pos, end_pos)
    [start_pos[0] + end_pos[0], start_pos[1] + end_pos[1]]
  end

  def valid_move?(move)
    move.all? { |coord| coord.between?(0,7) }
  end


end
