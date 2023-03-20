require_relative 'piece.rb'

class King < Piece
  attr_reader :colour, :symbol, :past_moves, :moved, :move_list

  def initialize(colour, symbol)
    @board = Board.new
    @colour = colour
    @symbol = symbol
    @past_moves = []
    @moved = false
  end
end