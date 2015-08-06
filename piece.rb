require 'byebug'
require 'colorize'

require_relative 'custom_error.rb'
class Piece
  RED_MOVES =   [[ 1, -1],[ 1, 1]]
  BLACK_MOVES = [[-1, -1],[-1, 1]]
  attr_reader :color, :board
  attr_accessor :pos, :rank

  def initialize(color, pos, board, rank=:pawn)
    @color, @pos, @board, @rank = color, pos, board, rank
    board.add_piece(self)
  end

  def to_s
    "O".colorize(color)
  end

  def move_dirs #needs to be updated for rank == :king
    color == :red ? RED_MOVES : BLACK_MOVES
  end

  def valid_moves?(moves)
    test_board = board.dup
    begin
      test_board[self.pos].perform_moves!(moves)
    rescue InvalidMoveError => e
      puts "#{e.move} #{e.message}"
      false
    end
    true
  end

  def valid_slide_or_jump?(move)
    slides.include?(move) || jumps.include?(move)
  end

  def perform_moves(moves)
   if valid_moves?(moves)
    #  debugger
     perform_moves!(moves)
   else
     puts "#{e.move} #{e.message}"
   end
  end

  def perform_moves!(moves)

    raise InvalidMoveError.new, 'enter at least one move' if moves.count < 1
    if moves.count == 1
      move = moves[0]
      raise InvalidMoveError.new(move),'is not a valid move' unless valid_slide_or_jump?(move)
      slides.include?(move) ? perform_slide(move) : perform_jump(move)
    else
      moves.each do |move|
        raise InvalidMoveError.new(move),'is an invalid jump' unless jumps.include?(move)
        perform_jump(move)
      end
    end
  end

  def perform_slide(new_pos)
    if slides.include?(new_pos)
      board.update_move(self, new_pos)
      true
    else
      false
    end
  end

  def perform_jump(new_pos)
    if jumps.include?(new_pos)
      blocked_pos = new_slide(pos, jump_direction(pos, new_pos))
      board[blocked_pos] = nil
      board.update_move(self, new_pos)
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
      jumps << jump_pos if board.can_jump?(blocked_pos, color, jump_pos)
    end

    jumps.select { |move| board.valid_move?(move) }
  end

  def slides
    slides = []
      move_dirs.each do |direction|
        potential_slide = new_slide(pos, direction)
        slides << potential_slide if board.empty?(potential_slide)
      end

    slides.select { |move| board.valid_move?(move) }
  end

  def new_slide(start_pos, dir)
    [start_pos[0] + dir[0], start_pos[1] + dir[1]]
  end

  def new_jump(start_pos, dir)
    [start_pos[0] + dir[0] * 2, start_pos[1] + dir[1] * 2]
  end

  def jump_direction(start_pos, end_pos)
    [(end_pos[0] - start_pos[0]) / 2, (end_pos[1] - start_pos[1]) / 2]
  end

end
