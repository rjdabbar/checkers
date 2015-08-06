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

  def perform_slide(new_pos)
    if slides.include?(new_pos)
      board[pos] = nil
      self.pos = new_pos
      board[new_pos] = self
      true
    else
      false
    end
  end

  def moves
    jumps + slides
  end

  def jumps
    jumps = []
    move_dirs.each do |direction|
      jump_pos = new_jump(pos, direction)
      blocked_pos = new_slide(pos, direction)

      jumps << potential_jump if board.can_jump?(blocked_pos, color, jump_pos)
    end

    jumps.select { |move| valid_move?(move) }
  end

  def slides
    slides = []
      move_dirs.each do |direction|
        potential_slide = new_slide(pos, direction)
        slides << potential_slide if board.empty?(potential_slide)
      end

    slides.select { |move| valid_move?(move) }
  end

  def new_slide(start_pos, dir)
    [start_pos[0] + dir[0], start_pos[1] + dir[1]]
  end

  def new_jump(start_pos, dir)
    [start_pos[0] + dir[0]*2, start_pos[1] + dir[1]*2]
  end

  def valid_move?(move)
    move.all? { |coord| coord.between?(0,7) }
  end


end
