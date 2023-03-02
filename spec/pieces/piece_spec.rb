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

  describe '#current_square' do 
end