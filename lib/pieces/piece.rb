require 'pry-byebug'

class Piece
  attr_accessor :current_square, :symbol, :colour, :current_square_colour, :start_square, :move_list, :past_moves, :moved

  def initialize(colour)
    @symbol = nil
    @colour = colour
    @current_square = nil
    @current_square_colour = nil
    @start_square = nil
    @move_list = []
    @past_moves = []
    @moved = false
  end

  def update_current_square(square)
    @moved = true
    @past_moves << square
    @current_square = square
  end

  def update_square_colour(colour)
    @current_square_colour = colour
  end

  def opposition_piece?(piece)
    piece.colour != @colour
  end

  def valid_moves(board)
    moves = []
    @move_list.each do |move|
      current = board.square_to_arr(@current_square)
      next_square = [move[0] + current[0], move[1] + current[1]]
      while board.square_exists?(board.arr_to_square(next_square))
        break if !board.square_empty?(board.arr_to_square(next_square))
        moves << board.arr_to_square(next_square)
        next_square = [move[0] + next_square[0], move[1] + next_square[1]]
      end
    end
    moves
  end

  def capturable(board)
    capturable_squares = []
    @move_list.each do |move|
      current = board.square_to_arr(@current_square)
      next_square = [move[0] + current[0], move[1] + current[1]]
      while board.square_exists?(board.arr_to_square(next_square))
        break if !board.square_empty?(board.arr_to_square(next_square)) && board.piece_on_square(board.arr_to_square(next_square)).colour == @colour
        capturable_squares << board.arr_to_square(next_square) if !board.square_empty?(board.arr_to_square(next_square)) && opposition_piece?(board.squares[board.square_to_index(board.arr_to_square(next_square))][:piece])
        next_square = [move[0] + next_square[0], move[1] + next_square[1]]
      end
    end
    capturable_squares
  end

  def valid_move?(square, board)
    valid_moves(board).include?(square) || capturable(board).include?(square)
  end

  def can_take?(square, board)
    capturable(board).include?(square)
  end

  def check?(board)
    arr = capturable(board)
    arr.each do |square|
      return true if board.piece_on_square(square).instance_of?(King)
    end
    false
  end

  def checkmate?(king, board)
    king.valid_moves(board).all? { |move| valid_move?(move) }
  end

end