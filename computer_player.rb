class ComputerPlayer

  attr_reader :color, :board, :other_color

  def initialize(color, board)
    @color, @board = color, board
    @other_color = (color == :red ? :black : :red)
  end


  def play_turn

  end

  def capture_moves
    moves = []
    board.pieces(color).each do |piece|
      moves << piece.jumps
    end
    moves
  end

  def king_moves
    moves = []
    board.pieces(color).each do |piece|
      piece.all_moves.each do |move|
        moves << move   if at_back_row?(move, color)
      end
    end
    moves
  end

  def at_back_row?(pos, color)
    return true if pos[0] == 0 && color == :black
    return true if pos[0] == 7 && color == :red
    false
  end

  def safe_moves
    moves = []
    test_board = board.dup
    test_board.pieces.each do |piece|
      piece.all_moves.each do |move|
        test_board.make_moves(color, piece, move)
        test_board.pieces(other_color)
      end
    end

  moves
  end

  def random_move

  end


end
