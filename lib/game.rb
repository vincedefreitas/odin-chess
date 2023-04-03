require_relative 'board'
require_relative 'pieces/pawn.rb'
require_relative 'pieces/knight.rb'
require_relative 'pieces/bishop.rb'
require_relative 'pieces/rook.rb'
require_relative 'pieces/king.rb'
require_relative 'pieces/queen.rb'
require_relative 'player'
require_relative 'display_text'
require 'pry-byebug'

class Game 
  include DisplayText
  attr_accessor :board, :current_player, :player_white, :player_black, :game_over

  def initialize
    @board = Board.new
    @player_white = Player.new('white')
    @player_black = Player.new('black')
    @current_player = @player_white
    @game_over = false
  end

  def switch_player
    @current_player == @player_white ? @current_player = @player_black : @current_player = @player_white
  end

  def player_choice
    input = user_input(intro_text)
    until input == '1' || input.upcase == 'Q'
      input = user_input(input_error)
    end
    @board.set_up_board if input == '1'
    quit if input.upcase == 'Q'
  end

  def user_input(prompt)
    puts prompt
    gets.chomp
  end

  def select_piece
    puts "#{@current_player.colour.capitalize}'s King is in check!" if king_in_check?
    square = user_input(user_piece_selection(@current_player.colour)).downcase
    square = user_input(invalid_coordinates).downcase until board.square_exists?(square) && !board.square_empty?(square) 
    piece = @board.piece_on_square(square)
    until piece_correct_colour?(piece)
      square = user_input(invalid_coordinates) 
      piece = @board.piece_on_square(square)
    end
    until has_valid_moves?(piece)
      square = user_input(no_valid_moves)
      square = user_input(invalid_coordinates) until !board.square_empty?(square)
      piece = @board.piece_on_square(square)
    end
    piece
  end

  def piece_correct_colour?(piece)
    piece.colour == @current_player.colour
  end

  def has_valid_moves?(piece)
    !piece.valid_moves(@board).empty? || !piece.capturable(@board).empty?
  end

  def select_move(piece)
    move = user_input(user_move_selection).downcase
    move = user_input(invalid_move).downcase until piece.valid_move?(move, @board)
    move
  end

  def move_piece(piece, move)
    @board.remove_piece(piece.current_square)
    piece.update_current_square(move)
    @board.update_piece(move, piece)
  end

  def king_in_check?
    @board.squares.each do |square|
      piece = square[:piece]
      next if piece.nil?
      next if piece.colour == @current_player.colour
      captures = piece.capturable(@board)
      captures.each do |capture|
        return true if @board.piece_on_square(capture).instance_of?(King)
      end
    end
    false
  end

  def check_checkmate?
    king = nil

    @board.squares.each do |square|
      king = square[:piece] if square[:piece].instance_of?(King) && square[:piece].colour != @current_player.colour
    end

    @board.squares.each do |square|
      piece = square[:piece]
      next if piece.nil?
      next if piece.colour != @current_player.colour
      return true if piece.checkmate?(king, @board)
    end
    false
  end

  def quit
    @game_over = true
  end


end

game = Game.new
game.player_choice

until game.game_over
  game.board.display_board
  piece = game.select_piece
  move = game.select_move(piece)
  game.move_piece(piece, move)
  p game.check_checkmate?
  game.switch_player
end


