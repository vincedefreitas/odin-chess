require './lib/pieces/knight.rb'

describe Knight do
  subject(:knight) { Knight.new('white', "\u2658")}

  describe '#valid_moves' do
    context 'if no pieces in way' do
      it 'returns an array of all possible moves within confines of board' do
        knight.current_square = 'd4'
        result = knight.valid_moves
        expect(result).to eq(['e6', 'c6', 'f5', 'b5', 'b3', 'c2', 'e2', 'f3'])
      end
    end

    context 'if pieces in way' do
      it 'returns an array of all possible moves within confines of board' do
        knight.board.update_piece('d5', 'pawn')
        knight.board.update_piece('c5', 'pawn')
        knight.board.update_piece('d3', 'pawn')
        knight.current_square = 'd4'
        result = knight.valid_moves
        expect(result).to eq(['e6', 'c6', 'f5', 'b5', 'b3', 'c2', 'e2', 'f3'])
      end
    end

    context 'if on edge of board' do
      it 'returns an array of all possible moves within confines of board' do
        knight.current_square = 'h5'
        result = knight.valid_moves
        expect(result).to eq(['g7', 'f6', 'f4', 'g3'])
      end
    end

    context 'if another piece on square' do
      it 'should not return this square as part of the array' do
        knight.current_square = 'h5'
        knight.board.update_piece('f6', 'pawn')
        result = knight.valid_moves
        expect(result).to eq(['g7', 'f4', 'g3'])
      end
    end
  end

  describe '#capturable' do
    it 'returns an array of squares containing pieces that can be captured' do
      black_pawn = Piece.new('black')
      white_pawn = Piece.new('white')
      knight.board.update_piece('f5', black_pawn)
      knight.board.update_piece('b3', black_pawn)
      knight.board.update_piece('e2', black_pawn)
      knight.board.update_piece('c6', white_pawn )
      knight.current_square = 'd4'
      result = knight.capturable
      expect(result).to eq(['f5', 'b3', 'e2'])
    end
  end

  describe '#valid_move?' do
    context 'if move is valid' do
      it 'returns true' do
        black_pawn = Piece.new('black')
        knight.board.update_piece('c2', black_pawn)
        knight.current_square = 'd4'
        result_one = knight.valid_move?('e6')
        result_two = knight.valid_move?('f3')
        result_three = knight.valid_move?('c2')
        expect(result_one).to be true
        expect(result_two).to be true
        expect(result_three).to be true
      end
    end

    context 'if move is not valid' do
      it 'returns false' do
        white_pawn = Piece.new('white')
        knight.board.update_piece('c2', white_pawn)
        knight.current_square = 'd4'
        result_one = knight.valid_move?('c2')
        result_two = knight.valid_move?('d6')
        result_three = knight.valid_move?('j4')
        result_four = knight.valid_move?('f2')
        expect(result_one).to be false
        expect(result_two).to be false
        expect(result_three).to be false
        expect(result_four).to be false
      end
    end
  end

end