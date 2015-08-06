class Game

  def initialize
    @board = Board.new
    @players = {red: HumanPlayer.new(:red), black: HumanPlayer.new(:black)}

  end

end


class HumanPlayer

  def initialize(color)
    @color = color

  end
end
