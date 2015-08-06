require_relative 'board.rb'
class Game

  attr_reader :players, :board
  attr_accessor :current_player
  def initialize
    @board = Board.new
    @players = {red: HumanPlayer.new(:red), black: HumanPlayer.new(:black)}
    @current_player = players.shuffle.first
  end

  def play
    until board.over?
      current_player.play_turn(board)
      current_player = (current_player == :red) ? :black : :red
    end
  end
end


class HumanPlayer

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn(board)
    moves = []
    begin
      piece = get_piece
      moves << get_move
      board.make_moves(piece, moves)
    rescue InvalidMoveError => e
      puts "#{e.move} #{e.message}"
      retry
    end
  end

  def get_piece
    puts "Which piece would you like to move?"
    gets.chomp.split(',').map { |coord| Integer(coord) }
  end

  def get_move
    puts "Enter moves you would like to make. Press Q to enter your moves"
    gets.chomp.split(',').map { |coord| Integer(coord) }
  end

end
