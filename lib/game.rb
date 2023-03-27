require_relative 'board'
require_relative 'pieces/pawn.rb'
require_relative 'player'

class Game 
  attr_accessor :board

  def initialize
    @board = Board.new
    @player_white = Player.new('white')
    @player_black = Player.new('black')
    @current_player = @player_white
  end


end

game = Game.new
game.board.set_up_squares
game.board.set_up_pawns('white', 2, "\u2659")
game.board.display_board
