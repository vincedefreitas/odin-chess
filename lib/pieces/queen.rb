require_relative 'piece.rb'

class Queen < Piece
  attr_reader :colour, :symbol, :move_list, :past_moves

  def initialize(colour, symbol)
    @colour = colour
    @symbol = symbol
    @move_list = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
    @past_moves = []
  end
end


