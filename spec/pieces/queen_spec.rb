require './lib/pieces/queen.rb'

describe Queen do
  subject(:queen) { Queen.new('white', "\u2655") }

  describe '#valid_moves' do
    context 'if no piece in way' do
      it 'returns an array of all possible moves within confines of board' do
        queen.current_square = 'd4'
        result = queen.valid_moves
        expect(result).to eq(['e4', 'f4', 'g4', 'h4', 'c4', 'b4', 'a4', 'd5', 'd6', 'd7', 'd8', 'd3', 'd2', 'd1', 'e5', 'f6', 'g7', 'h8', 'c3', 'b2', 'a1', 'e3', 'f2', 'g1', 'c5', 'b6', 'a7'])
      end
    end

    context 'if piece in way' do
      it 'returns an array of all possible moves within confines of board' do
        queen.board.update_piece('g4', 'pawn')
        queen.board.update_piece('a4', 'pawn')
        queen.board.update_piece('d7', 'pawn')
        queen.board.update_piece('d1', 'pawn')
        queen.board.update_piece('g7', 'pawn')
        queen.board.update_piece('a1', 'pawn')
        queen.board.update_piece('g1', 'pawn')
        queen.board.update_piece('a7', 'pawn')
        queen.current_square = 'd4'
        result = queen.valid_moves
        expect(result).to eq(['e4', 'f4', 'c4', 'b4', 'd5', 'd6', 'd3', 'd2', 'e5', 'f6', 'c3', 'b2', 'e3', 'f2', 'c5', 'b6'])
      end
    end

  end

end