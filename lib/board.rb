require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'

class Board
  attr_accessor :squares

  def initialize
    @squares = Array.new(64) {{reference: nil, colour: nil, piece: nil, column: nil, row: nil}}
  end

  def square_to_index(square)
    col = letter_to_column(square[0])
    row = square[1].to_i
    (8 - row) * 8 + col - 1
  end

  def letter_to_column(letter)
    letter.ord - 96
  end

  def column_to_letter(number)
    (number + 96).chr
  end

  def index_to_row(index)
    (63 - index) / 8 + 1
  end

  def index_to_column(index)
    index % 8 + 1
  end

  def index_to_square(index)
    num_col = index_to_column(index)
    letter_col = column_to_letter(num_col)
    row = index_to_row(index)
    "#{letter_col}#{row}"
  end

  def square_to_arr(square)
    [letter_to_column(square[0]), square[1].to_i]
  end

  def arr_to_square(arr)
    "#{column_to_letter(arr[0])}#{arr[1]}"
  end

  def colour_squares
    @squares.each_with_index do |square, index|
      if index_to_row(index).even?
        index % 2 == 0 ? square[:colour] = 'white' : square[:colour] = 'black'
      else
        index % 2 == 0 ? square[:colour] = 'black' : square[:colour] = 'white'
      end
    end
  end

  def squares_reference
    @squares.each_with_index do |square, index|
      square[:reference] = index_to_square(index)
    end
  end

  def squares_column
    @squares.each_with_index do |square, index|
      col_num = index_to_column(index)
      square[:column] = column_to_letter(col_num)
    end
  end

  def squares_row
    @squares.each_with_index do |square, index|
      square[:row] = index_to_row(index)
    end
  end

  def set_up_squares
    colour_squares
    squares_reference
    squares_column
    squares_row
  end

  def board_empty?
    @squares.all? { |square| square[:piece] == nil }
  end

  def square_empty?(square)
    index = square_to_index(square)
    @squares[index][:piece].nil?
  end

  def piece_on_square(square)
    index = square_to_index(square)
    @squares[index][:piece]
  end

  def colour_of_square(square)
    index = square_to_index(square)
    @squares[index][:colour]
  end

  def update_piece(square, piece)
    index = square_to_index(square)
    @squares[index][:piece] = piece
  end

  def remove_piece(square)
    index = square_to_index(square)
    @squares[index][:piece] = nil
  end

  def square_exists?(square)
    col = letter_to_column(square[0])
    row = square[1..].to_i
    col > 0 && col < 9 && row > 0 && row < 9
  end

  def display_board
    row = 8
    @squares.each_with_index do |square, index|
      if square[:colour] == 'white' && square[:row] == row && square[:column] == 'h'
        print "\e[47m #{square[:piece].symbol} \e[0m" if !square[:piece].nil?
        print "\e[47m   \e[0m" if square[:piece].nil?
        puts
        row -= 1
      elsif square[:colour] == 'black' && square[:row] == row && square[:column] == 'h'
        print "\e[100m #{square[:piece].symbol} \e[0m" if !square[:piece].nil?
        print "\e[100m   \e[0m" if square[:piece].nil?
        puts
        row -= 1
      elsif square[:colour] == 'white' && square[:row] == row
        print "\e[47m #{square[:piece].symbol} \e[0m" if !square[:piece].nil?
        print "\e[47m   \e[0m" if square[:piece].nil?
      elsif square[:colour] == 'black' && square[:row] == row 
        print "\e[100m #{square[:piece].symbol} \e[0m" if !square[:piece].nil?
        print "\e[100m   \e[0m" if square[:piece].nil?
      end
    end
  end

  def set_up_pawns(colour, row, symbol)
    @squares.each do |square|
      square[:piece] = Pawn.new(colour, symbol, square[:reference]) if square[:row] == row
    end
  end

  def set_up_pieces(colour)
    colour == 'white' ? @squares[square_to_index('a1')][:piece] = Rook.new('white', "\u2656", 'a1') : @squares[square_to_index('a8')][:piece] = Rook.new('black', "\u265C", 'a8') 
    colour == 'white' ? @squares[square_to_index('b1')][:piece] = Knight.new('white', "\u2658", 'b1') : @squares[square_to_index('b8')][:piece] = Knight.new('black', "\u265E", 'b8')
    colour == 'white' ? @squares[square_to_index('c1')][:piece] = Bishop.new('white', "\u2657", 'c1') : @squares[square_to_index('c8')][:piece] = Bishop.new('black', "\u265D", 'c8')
    colour == 'white' ? @squares[square_to_index('d1')][:piece] = Queen.new('white', "\u2655", 'd1') : @squares[square_to_index('d8')][:piece] = Queen.new('black', "\u265B", 'd8')
    colour == 'white' ? @squares[square_to_index('e1')][:piece] = King.new('white', "\u2654", 'e1') : @squares[square_to_index('e8')][:piece] = King.new('black', "\u265A", 'e8')
    colour == 'white' ? @squares[square_to_index('f1')][:piece] = Bishop.new('white', "\u2657", 'f1') : @squares[square_to_index('f8')][:piece] = Bishop.new('black', "\u265D", 'f8')
    colour == 'white' ? @squares[square_to_index('g1')][:piece] = Knight.new('white', "\u2658", 'g1') : @squares[square_to_index('g8')][:piece] = Knight.new('black', "\u265E", 'g8') 
    colour == 'white' ? @squares[square_to_index('h1')][:piece] = Rook.new('white', "\u2656", 'h1') : @squares[square_to_index('h8')][:piece] = Rook.new('black', "\u265C", 'h8')       
  end

  def set_up_board
    set_up_squares
    set_up_pieces('white')
    set_up_pieces('black')
    set_up_pawns('white', 2, "\u2659")
    set_up_pawns('black', 7, "\u265F")
  end

end

# board = Board.new
# board.set_up_board
# board.display_board
