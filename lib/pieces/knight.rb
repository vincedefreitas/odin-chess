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

  def valid_moves
    moves = []
    @move_list.each do |move|
      current = @board.square_to_arr(@current_square)
      next_square = [move[0] + current[0], move[1] + current[1]]
      moves << @board.arr_to_square(next_square) if @board.square_exists?(@board.arr_to_square(next_square)) && @board.square_empty?(@board.arr_to_square(next_square))
    end
    moves
  end
end