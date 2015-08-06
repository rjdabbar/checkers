require_relative 'board.rb'
class Game

  attr_reader :players, :board

  def initialize
    @board = Board.new
    @players = {red: HumanPlayer.new(:red), black: HumanPlayer.new(:black)}
  end

end


class HumanPlayer

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_move
     gets.chomp.split(',').map { |coord| Integer(coord) }
  end
end
