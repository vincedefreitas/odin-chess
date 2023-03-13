require_relative '../board.rb'
require 'pry-byebug'

class Piece
  attr_accessor :current_square, :symbol, :colour, :current_square_colour, :start_square, :move_list, :past_moves, :board

  def initialize(colour)
    @board = Board.new
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

  def potential_moves
    current = @board.square_to_arr(@current_square)
    potential_moves_arr = []
    @move_list.each do |move|
      potential_moves_arr << @board.arr_to_square([move[0] + current[0], move[1] + current[1]])
    end
    potential_moves_arr
  end

  def opposition_piece?(piece)
    piece.colour != @colour
  end

  def valid_moves
    moves = []
    @move_list.each do |move|
      current = @board.square_to_arr(@current_square)
      next_square = [move[0] + current[0], move[1] + current[1]]
      while @board.square_exists?(@board.arr_to_square(next_square))
        break if !@board.square_empty?(@board.arr_to_square(next_square))
        moves << @board.arr_to_square(next_square)
        next_square = [move[0] + next_square[0], move[1] + next_square[1]]
      end
    end
    moves
  end

  def capturable
    capturable_squares = []
    @move_list.each do |move|
      current = @board.square_to_arr(@current_square)
      next_square = [move[0] + current[0], move[1] + current[1]]
      while @board.square_exists?(@board.arr_to_square(next_square))
        capturable_squares << @board.arr_to_square(next_square) if !@board.square_empty?(@board.arr_to_square(next_square)) && opposition_piece?(@board.squares[@board.square_to_index(@board.arr_to_square(next_square))][:piece])
        next_square = [move[0] + next_square[0], move[1] + next_square[1]]
      end
    end
    capturable_squares
  end

  def valid_move?(square)
    valid_moves.include?(square) || capturable.include?(square)
  end

  def can_take?(square)
    capturable.include?(square)
  end

end