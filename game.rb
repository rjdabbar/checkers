require_relative 'board.rb'
class Game

  attr_reader :players, :board
  attr_accessor :current_player
  def initialize
    @board = Board.new
    @players = {red: HumanPlayer.new(:red), black: HumanPlayer.new(:black)}
    @current_player = players.keys.shuffle.first
  end

  def play
    until board.over?
      players[current_player].play_turn(board)
      self.current_player = (current_player == :red) ? :black : :red
    end

    board.render
    puts "#{board.winner.to_s.upcase} WINS!!!"
  end
end


class HumanPlayer

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn(board)
    board.render
    puts "#{color.to_s.upcase}'s TURN'"
    piece = get_piece
    begin
      board.make_moves(piece, get_moves)
    rescue

      retry
    end
  end

  def get_piece
    puts "Which piece would you like to move?"
    gets.chomp.split(',').map { |coord| Integer(coord) }
  end

  def get_moves
    puts "Enter moves you would like to make."
    gets.chomp.split(',').map { |coord| Integer(coord) }.each_slice(2).to_a
  end

end

if $PROGRAM_NAME == __FILE__
  Game.new.play
end
