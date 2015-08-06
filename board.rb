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
end
