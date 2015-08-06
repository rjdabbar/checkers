class Game

  def initialize
    @board = Board.new
    @players = {red: HumanPlayer.new, black: HumanPlayer.new}

  end

end
