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
      expect(colour).to eq('white')
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
      expect(result).to eq('black')
      expect(result_two).to eq('white')
    end
  end

  describe '#update_piece' do
    it 'updates piece on square' do
      board.update_piece('c5', 'queen')
      piece = board.piece_on_square('c5')
      expect(piece).to eq('queen')
    end
  end

  describe '#remove_piece' do
    it 'removes a piece from a square' do
      board.update_piece('h8', 'knight')
      board.remove_piece('h8')
      piece = board.piece_on_square('h8')
      expect(piece).to be_nil
    end
  end

  describe '#square_to_arr' do
    it 'converts a square to array format' do
      result = board.square_to_arr('c5')
      expect(result).to eq([3, 5])
    end
  end

  describe '#arr_to_square' do
    it 'converts an array to a square' do
      result = board.arr_to_square([3, 5])
      expect(result).to eq('c5')
    end
  end

  describe '#square_exists?' do
    context 'if square exists on the board' do
      it 'returns true' do
        result = board.square_exists?('h8')
        expect(result).to be true
      end
    end
  
    context 'if square does not exist on board' do
      it 'returns false' do
        result = board.square_exists?('i1')
        expect(result).to be false
      end
    end

  end

  describe '#set_up_pawns' do
    context 'if colour = white' do
      it 'sets up white pawns' do
        board.set_up_squares
        board.set_up_pawns('white', 2, "\u2659")
        arr = []
        board.squares.each { |square| arr << square[:piece] if square[:row] == 2 }
        expect(arr.all? { |element| element.instance_of?(Pawn) } ).to be true
      end
    end

    context 'if colour = black' do
      it 'sets up black pawns' do
        board.set_up_squares
        board.set_up_pawns('black', 7, "\u265F")
        arr = []
        board.squares.each { |square| arr << square[:piece] if square[:row] == 7 }
        expect(arr.all? { |element| element.instance_of?(Pawn) } ).to be true
      end
    end
  end

  describe '#set_up_pieces' do
    before do
      board.set_up_squares
    end

    context 'if colour = white' do
      before do
        board.set_up_pieces('white')
      end

      it 'sets up 1st rank "a" Rook' do
        result = board.squares[board.square_to_index('a1')][:piece]
        expect(result.instance_of?(Rook)).to be true
      end

      it 'sets up 1st rank "b" Knight' do
        result = board.squares[board.square_to_index('b1')][:piece]
        expect(result.instance_of?(Knight)).to be true
      end

      it 'sets up 1st rank "c" Bishop' do
        result = board.squares[board.square_to_index('c1')][:piece]
        expect(result.instance_of?(Bishop)).to be true
      end

      it 'sets up 1st rank "d" Queen' do
        result = board.squares[board.square_to_index('d1')][:piece]
        expect(result.instance_of?(Queen)).to be true
      end

      it 'sets up 1st rank "e" King' do
        result = board.squares[board.square_to_index('e1')][:piece]
        expect(result.instance_of?(King)).to be true
      end

      it 'sets up 1st rank "f" Bishop' do
        result = board.squares[board.square_to_index('f1')][:piece]
        expect(result.instance_of?(Bishop)).to be true
      end

      it 'sets up 1st rank "g" Knight' do
        result = board.squares[board.square_to_index('g1')][:piece]
        expect(result.instance_of?(Knight)).to be true
      end

      it 'sets up 1st rank "h" Rook' do
        result = board.squares[board.square_to_index('h1')][:piece]
        expect(result.instance_of?(Rook)).to be true
      end
    end

    context 'if colour = black' do
      before do
        board.set_up_pieces('black')
      end

      it 'sets up 8th rank "a" Rook' do
        result = board.squares[board.square_to_index('a8')][:piece]
        expect(result.instance_of?(Rook)).to be true
      end

      it 'sets up 8th rank "b" Knight' do
        result = board.squares[board.square_to_index('b8')][:piece]
        expect(result.instance_of?(Knight)).to be true
      end

      it 'sets up 8th rank "c" Bishop' do
        result = board.squares[board.square_to_index('c8')][:piece]
        expect(result.instance_of?(Bishop)).to be true
      end

      it 'sets up 8th rank "d" Queen' do
        result = board.squares[board.square_to_index('d8')][:piece]
        expect(result.instance_of?(Queen)).to be true
      end

      it 'sets up 8th rank "e" King' do
        result = board.squares[board.square_to_index('e8')][:piece]
        expect(result.instance_of?(King)).to be true
      end

      it 'sets up 8th rank "f" Bishop' do
        result = board.squares[board.square_to_index('f8')][:piece]
        expect(result.instance_of?(Bishop)).to be true
      end

      it 'sets up 8th rank "g" Knight' do
        result = board.squares[board.square_to_index('g8')][:piece]
        expect(result.instance_of?(Knight)).to be true
      end

      it 'sets up 8th rank "h" Rook' do
        result = board.squares[board.square_to_index('h8')][:piece]
        expect(result.instance_of?(Rook)).to be true
      end
    end

  end



end