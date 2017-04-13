require_relative 'Board.rb'
require_relative 'Card.rb'
require_relative 'HumanPlayer.rb'
require_relative 'ComputerPlayer.rb'

class Game

  def initialize(board = Board.new, player = ComputerPlayer.new(board))
    @board = board
    @prev_guess = nil
    @player = player
    @incorrect = false
  end

  def play
    @board.populate

    until @board.won?
      @incorrect = false
      display_board
      @player.prompt
      pos = @player.get_input
      while pos == @prev_guess || @board[pos].face_up
        pos = @player.get_input
      end
      puts "Guess: #{pos}"
      make_guess(pos)
      @player.receive_revealed_card(pos, @board[pos])
    end

    display_board
    puts "GAME OVER"
  end

  def display_board
    system("clear")
    @board.render

    if @incorrect
      puts "WRONG"
      sleep(0.5)
      system("clear")
    end
  end

  def make_guess(pos)
    @board.reveal(pos)
    if @prev_guess.nil?
      @prev_guess = pos
      @player.receive_revealed_card(pos, @board[pos])
    elsif @board[@prev_guess] == @board[pos]
      @prev_guess = nil
      @player.receive_match(@prev_guess, pos)
    else
      @incorrect = true
      display_board
      @board[@prev_guess].hide
      @board[pos].hide
      @prev_guess = nil
      @player.receive_revealed_card(pos, @board[pos])
    end
  end


end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
