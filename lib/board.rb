

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

  def colour_squares
    @squares.each_with_index do |square, index|
      index % 2 == 0 ? square[:colour] = 'white' : square[:colour] = 'black'
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



end
