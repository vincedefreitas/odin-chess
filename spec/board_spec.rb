require './lib/board.rb'

describe Board do
  subject(:board) { Board.new }

  describe "#square_to_index" do
    it "takes a column and row and converts it to a board index" do
      result = board.square_to_index('c5')
      expect(result).to eq(26)
    end
  end

  describe '#letter_to_column' do
    it "takes a letter and converts it to a column numeric equivalent" do
      result = board.letter_to_column('d')
      result_two = board.letter_to_column('a')
      expect(result).to eq(4)
      expect(result_two).to eq(1)
    end
  end

  describe '#column_to_letter' do
    it 'takes a numeric column value and converts it to a letter' do
      result_one = board.column_to_letter(6)
      result_two = board.column_to_letter(3)
      expect(result_one).to eq('f')
      expect(result_two).to eq('c')
    end
  end

  describe '#index_to_row' do
    it 'takes the index and converts it to a row' do
      result = board.index_to_row(26)
      result_two = board.index_to_row(57)
      expect(result).to eq(5)
      expect(result_two).to eq(1)
    end
  end

  describe '#index_to_column' do
    it 'takes the index and converts it to a numeric column value' do
      result = board.index_to_column(3)
      result_two = board.index_to_column(63)
      expect(result).to eq(4)
      expect(result_two).to eq(8)
    end
  end

  describe '#index_to_square' do
    it 'takes the index and converts it to a square' do
      result = board.index_to_square(26)
      result_two = board.index_to_square(63)
      result_three = board.index_to_square(0)
      expect(result).to eq('c5')
      expect(result_two).to eq('h1')
      expect(result_three).to eq('a8')
    end
  end

  describe '#colour_squares' do
    it 'fills square with relevant colour' do
      board.colour_squares
      result = board.squares[0][:colour]
      result_two = board.squares[33][:colour]
      expect(result).to eq('white')
      expect(result_two).to eq('black')
    end
  end

  describe '#squares_reference' do
    it 'gives each square a square name/reference' do
      board.squares_reference
      result = board.squares[0][:reference]
      result_two = board.squares[26][:reference]
      expect(result).to eq('a8')
      expect(result_two).to eq('c5')
    end
  end

  describe '#squares_column' do
    it 'gives each square a column value' do
      board.squares_column
      result = board.squares[5][:column]
      result_two = board.squares[26][:column]
      expect(result).to eq('f')
      expect(result_two).to eq('c')
    end
  end

  describe '#squares_row' do
    it 'gives each square a row value' do
      board.squares_row
      result = board.squares[26][:row]
      result_two = board.squares[7][:row]
      expect(result).to eq(5)
      expect(result_two).to eq(8)
    end
  end

  describe '#set_up_squares' do
    it 'sets up the squares on the board with the relevant values' do
      board.set_up_squares
      colour = board.squares[63][:colour]
      reference = board.squares[63][:reference]
      column = board.squares[63][:column]
      row = board.squares[63][:row]
      expect(colour).to eq('black')
      expect(reference).to eq('h1')
      expect(column).to eq('h')
      expect(row).to eq(1)
    end
  end

  describe '#board_empty?' do
    context 'if board is empty (does not contain any pieces)' do
      it 'returns true' do
        result = board.board_empty?
        expect(result).to be true
      end
    end

    context 'if board is not empty (contains pieces)' do
      it 'returns false' do
        board.squares[34][:piece] = 'rook'
        result = board.board_empty?
        expect(result).to be false
      end
    end
  end

  describe '#square_empty?' do
    context 'if square is empty (does not contain a piece)' do
      it 'returns true' do
        result = board.square_empty?('c5')
        expect(result).to be true
      end
    end

    context 'if square is not empty (contains a piece)' do
      it 'returns false' do
        board.squares[26][:piece] = 'bishop'
        result = board.square_empty?('c5')
        expect(result).to be false
      end
    end
  end

  describe '#piece_on_square' do
    context 'if piece on square' do
      it 'returns piece as string' do
        board.squares[35][:piece] = 'pawn'
        result = board.piece_on_square('d4')
        expect(result).to eq('pawn')
      end
    end

    context 'if no piece on square' do
      it 'returns nil' do
        result = board.piece_on_square('d4')
        expect(result).to be_nil
      end
    end
  end

  describe '#colour_of_square' do
    it 'returns colour of square as a string' do
      board.set_up_squares
      result = board.colour_of_square('c3')
      result_two = board.colour_of_square('h1')
      expect(result).to eq('white')
      expect(result_two).to eq('black')
    end
  end


end