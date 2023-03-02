require_relative '../board.rb'

class Piece
  attr_accessor :current_square, :symbol, :colour, :current_square_colour, :start_square, :moves

  def initialize
    @board = Board.new
    @symbol = nil
    @colour = nil
    @current_square = nil
    @current_square_colour = nil
    @start_square = nil
    @moves = []
  end

  def update_current_square(square)
    @current_square = square
  end

end