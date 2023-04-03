require './lib/game.rb'

describe Game do
  subject(:game) { Game.new }
  
  describe '#switch_player' do
    it 'switches @current_player from white to black' do
      game.switch_player
      result = game.current_player
      expect(result).to eq(game.player_black)
    end

    it 'switches @current_player from black to white' do
      game.current_player = game.player_black
      game.switch_player
      result = game.current_player
      expect(result).to eq(game.player_white)
    end
  end

  


end