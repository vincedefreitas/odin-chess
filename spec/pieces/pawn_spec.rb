require './lib/pieces/pawn.rb'

describe Pawn do
  subject(:pawn) { Pawn.new('white', "\u2659") }

  describe '#generate_move_list' do
    context 'if @moved = false' do
      it 'changes @move_list to the relevant move list' do
        pawn.generate_move_list
        result = pawn.move_list
        expect(result).to eq([[0, 1], [0, 2]])
      end
    end

    context 'if @moved = true' do
      it 'changes @move_list to the relevant move list' do
        pawn.moved = true
        pawn.generate_move_list
        result = pawn.move_list
        expect(result).to eq([[0, 1]])
      end
    end
  end

  describe '#valid_moves' do
    context 'if no pieces in way & @moved = false' do
      it 'returns an array of all possible moves within confines of board' do
        pawn.current_square = 'd2'
        result = pawn.valid_moves
        expect(result).to eq(['d3', 'd4'])
      end
    end

    context 'if piece in way & @moved = false' do
      it 'returns an array of all possible moves within confines of board' do
        pawn.current_square = 'd2'
        pawn.board.update_piece('d4', 'pawn')
        result = pawn.valid_moves
        expect(result).to eq(['d3'])
      end
    end

    context 'if piece in way & @moved = false' do
      it 'returns an array of all possible moves within confines of board' do
        pawn.current_square = 'd2'
        pawn.board.update_piece('d3', 'pawn')
        result = pawn.valid_moves
        expect(result).to eq([])
      end
    end

    context 'if no pieces in way & @moved = true' do
      it 'returns an array of all possible moves within confines of board' do
        pawn.current_square = 'd4'
        pawn.moved = true
        result = pawn.valid_moves
        expect(result).to eq(['d5'])
      end
    end

    context 'if pieces in way & @moved = true' do
      it 'returns an array of all possible moves within confines of board' do
        pawn.current_square = 'd4'
        pawn.moved = true
        pawn.board.update_piece('d5', 'pawn')
        result = pawn.valid_moves
        expect(result).to eq([])
      end
    end
  end

  describe '#capturable' do
    it 'returns an array of squares containing pieces that can be captured' do
      black_pawn_one = Piece.new('black')
      black_pawn_two = Piece.new('black')
      white_pawn = Piece.new('white')
      pawn.board.update_piece('e5', black_pawn_one)
      pawn.board.update_piece('f6', black_pawn_two)
      pawn.board.update_piece('c5', white_pawn)
      pawn.current_square = 'd4'
      result = pawn.capturable
      expect(result).to eq(['e5'])
    end
  end


end