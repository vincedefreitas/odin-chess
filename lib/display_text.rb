module DisplayText
  def intro_text
    <<~HEREDOC
    
    Welcome to Chess!

    Each turn will require two choices. 
    
    First select the co-ordinates of the piece you would like to move.

    Second, enter the co-ordinates of any legal move or capture. That's all there is to it!

    Are you ready to play? Please enter '1' to continue or 'Q' to quit.

    HEREDOC
  end

  def user_piece_selection(player)
    <<~HEREDOC

    #{player.capitalize}'s turn.

    Enter the co-ordinates of the piece you would like to move.
    [Q] to Quit

    HEREDOC
  end

  def user_move_selection
    <<~HEREDOC

    Enter the co-ordinates of any legal move or capture.
    [Q] to Quit

    HEREDOC
  end

  def invalid_coordinates
    <<~HEREDOC

    Invalid coordinates! Enter column & row of the correct colour.
    [Q] to Quit

    HEREDOC
  end

  def no_valid_moves
    <<~HEREDOC

    This piece does not have any valid moves.
    Enter the co-ordinates of the piece you would like to move.
    [Q] to Quit

    HEREDOC
  end

  def invalid_move
    <<~HEREDOC

    Invalid coordinates! Enter a valid column & row to move.

    HEREDOC
  end

  def input_error
    <<~HEREDOC

    Input error! Enter '1' to continue or 'Q' to Quit

    HEREDOC
  end

end

