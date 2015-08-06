require_relative 'piece.rb'
require 'colorize'

class Board
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

  def add_piece(piece)
    self[piece.pos] = piece
  end

  def empty?(pos)
    self[pos].nil?
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
    @grid = Array.new(8) { Array.new(8) }
    return unless filled
    [:red, :black].each { |color| place_pieces(color)}
  end

  def place_pieces(color)
    start_rows = [[0,1,2], [5,6,7]]
    color == :red ? home = start_rows.shift : home = start_rows.pop

    home.each do |row|
      8.times do |col|
        if row.even? && col.even? || row.odd? && col.odd?
          Piece.new(color, [row, col], self)
        end
      end
    end
  end
end
