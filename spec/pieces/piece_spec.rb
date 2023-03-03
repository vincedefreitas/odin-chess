require './lib/pieces/piece.rb'

describe Piece do
  subject(:piece) { Piece.new }

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

  describe '#possible_moves' do
    it 'provides an array of all possible moves from current square' do
      piece.move_list = [[1, 1], [2, 2]]
      piece.current_square = 'c5'
      result = piece.possible_moves
      expect(result).to eq(['d6', 'e7'])
    end
  end

end