

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
    row = square[1].to_i
    col > 0 && col < 9 && row > 0 && row < 9
  end

  def display_board
    set_up_squares
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

end

class Piece
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end
end

board = Board.new
black_rook_a = Piece.new("\u265c")
black_rook_h = Piece.new("\u265c")
black_knight_b = Piece.new("\u265e")
black_knight_g = Piece.new("\u265e")
black_bishop_c = Piece.new("\u265d")
black_bishop_f = Piece.new("\u265d")
black_queen = Piece.new("\u265b")
black_king = Piece.new("\u265a")
board.squares[0][:piece] = black_rook_a
board.squares[7][:piece] = black_rook_h
board.squares[1][:piece] = black_knight_b
board.squares[6][:piece] = black_knight_g
board.squares[2][:piece] = black_bishop_c
board.squares[5][:piece] = black_bishop_f
board.squares[3][:piece] = black_queen
board.squares[4][:piece] = black_king
black_pawn_a = Piece.new("\u265f")
black_pawn_b = Piece.new("\u265f")
black_pawn_c = Piece.new("\u265f")
black_pawn_d = Piece.new("\u265f")
black_pawn_e = Piece.new("\u265f")
black_pawn_f = Piece.new("\u265f")
black_pawn_g = Piece.new("\u265f")
black_pawn_h = Piece.new("\u265f")
board.squares[8][:piece] = black_pawn_a
board.squares[9][:piece] = black_pawn_b
board.squares[10][:piece] = black_pawn_c
board.squares[11][:piece] = black_pawn_d
board.squares[12][:piece] = black_pawn_e
board.squares[13][:piece] = black_pawn_f
board.squares[14][:piece] = black_pawn_g
board.squares[15][:piece] = black_pawn_h

white_rook_a = Piece.new("\u2656")
white_rook_h = Piece.new("\u2656")
white_knight_b = Piece.new("\u2658")
white_knight_g = Piece.new("\u2658")
white_bishop_c = Piece.new("\u2657")
white_bishop_f = Piece.new("\u2657")
white_queen = Piece.new("\u2655")
white_king = Piece.new("\u2654")
board.squares[56][:piece] = white_rook_a
board.squares[63][:piece] = white_rook_h
board.squares[57][:piece] = white_knight_b
board.squares[62][:piece] = white_knight_g
board.squares[58][:piece] = white_bishop_c
board.squares[61][:piece] = white_bishop_f
board.squares[59][:piece] = white_queen
board.squares[60][:piece] = white_king
white_pawn_a = Piece.new("\u2659")
white_pawn_b = Piece.new("\u2659")
white_pawn_c = Piece.new("\u2659")
white_pawn_d = Piece.new("\u2659")
white_pawn_e = Piece.new("\u2659")
white_pawn_f = Piece.new("\u2659")
white_pawn_g = Piece.new("\u2659")
white_pawn_h = Piece.new("\u2659")
board.squares[48][:piece] = white_pawn_a
board.squares[49][:piece] = white_pawn_b
board.squares[50][:piece] = white_pawn_c
board.squares[51][:piece] = white_pawn_d
board.squares[52][:piece] = white_pawn_e
board.squares[53][:piece] = white_pawn_f
board.squares[54][:piece] = white_pawn_g
board.squares[55][:piece] = white_pawn_h

board.display_board