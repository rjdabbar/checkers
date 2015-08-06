require 'byebug'
class ComputerPlayer

  attr_reader :color, :board, :other_color

  def initialize(color, board)
    @color, @board = color, board
    @other_color = (color == :red ? :black : :red)
  end


  def play_turn(board)
    if !jump_moves.empty?
      piece = jump_moves.keys.shuffle.first
      move = jump_moves[piece].shuffle.first
      board.make_moves(color, piece.pos, [move])
    elsif !king_moves.empty?
      piece = king_moves.keys.shuffle.first
      move = king_moves[piece].shuffle.first
      board.make_moves(color, piece.pos, [move])
    else
      piece = random_moves.keys.shuffle.first
      move = random_moves[piece].shuffle.first
      board.make_moves(color, piece.pos, [move])
    end
  end

  def jump_moves
    moves = Hash.new { |h, k| h[k] = [] }
    board.pieces(color).each do |piece|
      moves[piece] = piece.jumps
    end
    moves.delete_if { |piece, moves| moves.empty? }
  end

  def king_moves
    moves = Hash.new { |h, k| h[k] = [] }
    board.pieces(color).each do |piece|
      piece.all_moves.each do |move|
        moves[piece] << move   if at_back_row?(move, color)
      end
    end
    moves.delete_if { |piece, moves| moves.empty? }
  end

  def at_back_row?(pos, color)
    return true if pos[0] == 0 && color == :black
    return true if pos[0] == 7 && color == :red
    false
  end

  def random_moves
    moves = Hash.new { |h, k| h[k] = [] }
    board.pieces(color).each do |piece|
      piece.all_moves.each do |move|
        moves[piece] << move
      end
    end
    moves.delete_if { |piece, moves| moves.empty? }
  end


end
