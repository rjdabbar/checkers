require_relative 'board.rb'
require_relative 'custom_error.rb'
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

    begin
      piece = get_piece
      board.make_moves(color, piece, get_moves)
    rescue InvalidInputError => e
      puts "#{e.input} #{e.message}"
      retry
    rescue InvalidPieceError => e
      puts "#{e.piece} #{e.message}"
      retry
    rescue InvalidMoveError => e
      puts "#{e.move} #{e.message}"
      retry
    end
  end

  def get_piece
    puts "Which piece would you like to move?"
    begin
      piece_pos = trim_input(gets.chomp)
    rescue ArgumentError
      raise InvalidInputError.new("that is not a valid input", piece_pos)
    end
  end

  def get_moves
    puts "Enter moves you would like to make."
    begin
      input = trim_input(gets.chomp).each_slice(2).to_a
    rescue ArgumentError
      raise InvalidInputError.new("that is not a valid input", input)
    end
  end

  def trim_input(input)
    input.split(',').map { |coord| Integer(coord) }
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new.play
end
