require './lib/pieces/piece.rb'

describe Piece do
  subject(:piece) { Piece.new('white') }

  describe '#update_current_square' do
    it 'updates the @current_square variable' do
      piece.update_current_square('d1')
      result = piece.current_square
      expect(result).to eq ('d1')
    end
  end

  describe '#update_square_colour' do
    it 'updates the @current_square_colour variable' do
      piece.update_square_colour('black')
      result = piece.current_square_colour
      expect(result).to eq('black')
    end
  end

  describe '#potential_moves' do
    it 'provides an array of all potential moves from current square' do
      piece.move_list = [[1, 1], [2, 2]]
      piece.current_square = 'c5'
      result = piece.potential_moves
      expect(result).to eq(['d6', 'e7'])
    end
  end

  describe '#opposition_piece?' do
    context 'if piece is opposition piece' do
      it 'returns true' do
        unidentified_piece = Piece.new('white')
        piece.colour = 'black'
        result = piece.opposition_piece?(unidentified_piece)
        expect(result).to be true
      end
    end

    context 'if piece is not opposition piece' do
      it 'returns false' do
        unidentified_piece = Piece.new('white')
        piece.colour = 'white'
        result = piece.opposition_piece?(unidentified_piece)
        expect(result).to be false
      end
    end
  end

  describe '#valid_moves' do
    context 'if no pieces in way' do
      it 'returns an array of all possible moves within confines of board' do
        piece.move_list = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
        piece.current_square = 'd4'
        result = piece.valid_moves
        expect(result).to eq(['e4', 'f4', 'g4', 'h4', 'c4', 'b4', 'a4', 'd5', 'd6', 'd7', 'd8', 'd3', 'd2', 'd1', 'e5', 'f6', 'g7', 'h8', 'c3', 'b2', 'a1', 'e3', 'f2', 'g1', 'c5', 'b6', 'a7'])
      end
    end

    context 'if no pieces in way & piece is a rook' do
      it 'returns an array of all possible moves within confines of board' do
        piece.move_list = [[1, 0], [-1, 0], [0, 1], [0, -1]]
        piece.current_square = 'd4'
        result = piece.valid_moves
        expect(result).to eq(['e4', 'f4', 'g4', 'h4', 'c4', 'b4', 'a4', 'd5', 'd6', 'd7', 'd8', 'd3', 'd2', 'd1'])
      end
    end

    context 'if no pieces in way & piece is a bishop' do
      it 'returns an array of all possible moves within confines of board' do
        piece.move_list = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
        piece.current_square = 'd4'
        result = piece.valid_moves
        expect(result).to eq(['e5', 'f6', 'g7', 'h8', 'c3', 'b2', 'a1', 'e3', 'f2', 'g1', 'c5', 'b6', 'a7'])
      end
    end

    context 'if pieces in way & piece is a queen' do
      it 'returns an array of all possible moves within confines of board' do
        piece.board.update_piece('g4', 'pawn')
        piece.board.update_piece('a4', 'pawn')
        piece.board.update_piece('d7', 'pawn')
        piece.board.update_piece('d1', 'pawn')
        piece.board.update_piece('g7', 'pawn')
        piece.board.update_piece('a1', 'pawn')
        piece.board.update_piece('g1', 'pawn')
        piece.board.update_piece('a7', 'pawn')
        piece.move_list = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
        piece.current_square = 'd4'
        result = piece.valid_moves
        expect(result).to eq(['e4', 'f4', 'c4', 'b4', 'd5', 'd6', 'd3', 'd2', 'e5', 'f6', 'c3', 'b2', 'e3', 'f2', 'c5', 'b6'])
      end
    end

  end

  describe '#capturable' do
    it 'returns an array of squares containing pieces that can be captured' do
      black_pawn = Piece.new('black')
      white_pawn = Piece.new('white')
      piece.board.update_piece('g4', black_pawn)
      piece.board.update_piece('d7', black_pawn)
      piece.board.update_piece('a1', black_pawn)
      piece.board.update_piece('a7', white_pawn )
      piece.move_list = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
      piece.current_square = 'd4'
      result = piece.capturable
      expect(result).to eq(['g4', 'd7', 'a1'])
    end
  end

  describe '#valid_move?' do
    context 'if move is valid' do
      it 'returns true' do
        black_pawn = Piece.new('black')
        piece.board.update_piece('d7', black_pawn)
        piece.move_list = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
        piece.current_square = 'd4'
        result_one = piece.valid_move?('b4')
        result_two = piece.valid_move?('d7')
        result_three = piece.valid_move?('e5')
        expect(result_one).to be true
        expect(result_two).to be true
        expect(result_three).to be true
      end
    end

    context 'if move is not valid' do
      it 'returns false' do
        black_pawn = Piece.new('black')
        piece.board.update_piece('d7', black_pawn)
        piece.move_list = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
        piece.current_square = 'd4'
        result_one = piece.valid_move?('d8')
        result_two = piece.valid_move?('d4')
        result_three = piece.valid_move?('e9')
        result_four = piece.valid_move?('a2')
        expect(result_one).to be false
        expect(result_two).to be false
        expect(result_three).to be false
        expect(result_four).to be false
      end
    end
  end

  describe 'can_take?' do
    context 'if square contains piece that you can take' do
      it 'returns true' do
        black_pawn = Piece.new('black')
        piece.board.update_piece('c4', black_pawn)
        piece.move_list = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
        piece.current_square = 'd4'
        result = piece.can_take?('c4')
        expect(result).to be true
      end
    end

    context 'if square does not contain piece that you can take' do
      it 'returns false' do
        piece.move_list = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
        piece.current_square = 'd4'
        result = piece.can_take?('c4')
        expect(result).to be false
      end
    end
  end

end