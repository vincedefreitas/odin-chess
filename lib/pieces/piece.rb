require_relative '../board.rb'

class Piece
  attr_accessor :current_square, :symbol, :colour, :current_square_colour, :start_square, :move_list, :past_moves

  def initialize
    @board = Board.new
    @symbol = nil
    @colour = nil
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

  def possible_moves
    current = @board.square_to_arr(@current_square)
    possible_moves_arr = []
    @move_list.each do |move|
      possible_moves_arr << @board.arr_to_square([move[0] + current[0], move[1] + current[1]])
    end
    possible_moves_arr
  end



end