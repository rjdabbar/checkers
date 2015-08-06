
require_relative 'piece.rb'
require 'byebug'
require 'colorize'

class Board
  BOARD_SIZE = 8
  START_ROWS = [[0,1,2], [5,6,7]]

  attr_reader :grid

  def initialize(filled=true)
    populate_board(filled)
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  def dup
    new_board = Board.new(false)

    pieces.each do |piece|
      Piece.new(piece.color, piece,pos, new_board, piece.rank)
    end
    new_board
  end

  def add_piece(piece)
    self[piece.pos] = piece
  end

  def pieces
    grid.flatten.compact
  end

  def empty?(pos)
    self[pos].nil?
  end

  def enemy?(pos, color)
    self[pos].color != color
  end

  def can_jump?(blocked_pos, color, jump_pos)
    empty?(jump_pos) && !empty?(blocked_pos) && enemy?(blocked_pos, color)
  end

  def valid_move?(move)
    move.all? { |coord| coord.between?(0, BOARD_SIZE - 1) }
  end

  def update_move(piece, end_pos)
    self[piece.pos] = nil
    piece.pos = end_pos
    self[end_pos] = piece
  end

  def render
    print "_________________________________________\n"
    grid.each_with_index do |row, row_idx|
      print "|"
      row.each_with_index do |col, col_idx|
        if self[[row_idx, col_idx]].nil?
          print "    |"
        else
          print "  #{self[[row_idx, col_idx]].to_s} |"
        end
      end
        print "\n|____|____|____|____|____|____|____|____|\n"
    end
    nil
  end

  def populate_board(filled)
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    return unless filled
    [:red, :black].each { |color| place_pieces(color)}
  end

  def place_pieces(color)
    color == :red ? home = START_ROWS.shift : home = START_ROWS.pop
    home.each do |row|
      BOARD_SIZE.times do |col|
        if row.even? && col.even? || row.odd? && col.odd?
          Piece.new(color, [row, col], self)
        end
      end
    end
  end

end

if $PROGRAM_NAME == __FILE__
    b = Board.new

    b.render

    b[[2,2]].perform_move_sequence([[3,3]])
    b.render
    b[[3,3]].perform_move_sequence([[4,4]])
    b.render
    b[[5,3]].perform_move_sequence([[3,5]])
    b.render

end
