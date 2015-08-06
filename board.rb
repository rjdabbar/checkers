class Board
   attr_reader :grid
  def initialize(filled=true)

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

  def populate_board(filled)
    @grid = Array.new(8) { Array.new(8) }
    return unless filled
    place_pieces
  end

  def place_pieces(color)
    start_rows = [[0,1,2], [5,6,7]]
    color == :red ? home = start_rows.shift : home = start_rows.pop

    home.each do |row|
      8.times do |col|
        if row.even? && col.even? || row.odd? && col.odd?
          Piece.new(color, self, [row, col])
        end
      end
    end
  end


end
