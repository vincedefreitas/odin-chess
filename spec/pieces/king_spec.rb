require './lib/pieces/king.rb'

describe King do
  subject(:king) { King.new('white', "\u2654") }

  describe '#valid_moves' do
    context 'if no pieces in way' do
      it 'returns an array of all possible moves within confines of board' do
        king.current_square = 'd4'
        result = king.valid_moves
        expect(result).to eq(['d5', 'e5', 'e4', 'e3', 'd3', 'c3', 'c4', 'c5'])
      end
    end

    context 'if pieces in way' do
      it 'returns an array of all possible moves within confines of board' do
        king.board.update_piece('d5', 'pawn')
        king.board.update_piece('e5', 'pawn')
        king.board.update_piece('e4', 'pawn')
        king.current_square = 'd4'
        result = king.valid_moves
        expect(result).to eq(['e3', 'd3', 'c3', 'c4', 'c5'])
      end
    end

    context 'if on edge of board' do
      it 'returns an array of all possible moves within confines of board' do
        king.current_square = 'h5'
        result = king.valid_moves
        expect(result).to eq(['h6', 'h4', 'g4', 'g5', 'g6'])
      end
    end

    context 'if another piece on square' do
      it 'should not return this square as part of the array' do
        king.current_square = 'h5'
        king.board.update_piece('h6', 'pawn')
        result = king.valid_moves
        expect(result).to eq(['h4', 'g4', 'g5', 'g6'])
      end
    end
  end
end