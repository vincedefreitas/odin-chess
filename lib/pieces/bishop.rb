require_relative 'piece.rb'

class Bishop < Piece
  attr_reader :colour, :symbol, :move_list, :past_moves, :current_square

  def initialize(colour, symbol, current_square)
    @colour = colour
    @symbol = symbol
    @current_square = current_square
    @move_list = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
    @past_moves = []
  end
end