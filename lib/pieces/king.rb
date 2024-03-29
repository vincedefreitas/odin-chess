require_relative 'piece.rb'

class King < Piece
  attr_reader :colour, :symbol, :past_moves, :moved, :move_list, :current_square

  def initialize(colour, symbol, current_square)
    @colour = colour
    @symbol = symbol
    @current_square = current_square
    @move_list = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
    @past_moves = []
    @moved = false
  end

  def valid_moves(board)
    moves = []
    @move_list.each do |move|
      current = board.square_to_arr(@current_square)
      next_square = [move[0] + current[0], move[1] + current[1]]
      next if !board.square_empty?(board.arr_to_square(next_square))
      moves << board.arr_to_square(next_square) if board.square_exists?(board.arr_to_square(next_square)) && board.square_empty?(board.arr_to_square(next_square))
    end
    moves
  end

end