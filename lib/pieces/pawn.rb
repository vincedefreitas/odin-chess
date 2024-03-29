require_relative 'piece.rb'

class Pawn < Piece
  attr_reader :colour, :symbol, :past_moves, :moved, :move_list, :current_square

  def initialize(colour, symbol, current_square)
    @colour = colour
    @symbol = symbol
    @current_square = current_square
    @past_moves = []
    @moved = false
  end

  def generate_move_list
    @move_list = [[0, 1], [0, 2]] if @moved == false && @colour == 'white'
    @move_list = [[0, 1]] if @moved == true && @colour == 'white'
    @move_list = [[0, -1], [0, -2]] if @moved == false && @colour == 'black'
    @move_list = [[0, -1]] if @moved == true && @colour == 'black'
  end

  def valid_moves(board)
    moves = []
    generate_move_list
    @move_list.each do |move|
      current = board.square_to_arr(@current_square)
      next_square = [move[0] + current[0], move[1] + current[1]]
      break if !board.square_empty?(board.arr_to_square(next_square))
      moves << board.arr_to_square(next_square) if board.square_exists?(board.arr_to_square(next_square)) && board.square_empty?(board.arr_to_square(next_square))
    end
    moves
  end

  def capturable(board)
    capturable_squares = []
    diagonal = [[1, 1], [-1, 1]]
    diagonal.each do |move|
      current = board.square_to_arr(@current_square)
      next_square = [move[0] + current[0], move[1] + current[1]]
      capturable_squares << board.arr_to_square(next_square) if !board.square_empty?(board.arr_to_square(next_square)) && opposition_piece?(board.squares[board.square_to_index(board.arr_to_square(next_square))][:piece])
    end
    capturable_squares
  end



end

