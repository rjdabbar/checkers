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
end
