require_relative 'piece.rb'

class Knight < Piece
  attr_reader :colour, :symbol, :move_list, :past_moves

  def initialize(colour, symbol)
    @board = Board.new
    @colour = colour
    @symbol = symbol
    @move_list = [[1, 2], [-1, 2], [2, 1], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
    @past_moves = []
  end
end