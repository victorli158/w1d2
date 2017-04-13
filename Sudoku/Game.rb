require_relative 'Board.rb'
require_relative 'Tile.rb'

class Game

  def initialize(board = Board.from_file('sudoku1-almost.txt'))
    @board = board
  end

  def play
    until @board.solved?
      @board.render
      pos, value = prompt
      if @board.valid?(pos)
        @board[pos] = value
      end
      system("clear")
    end
    puts "YOU DID IT"
  end

  def prompt
    puts "Enter a position"
    pos = gets.chomp.scan(/\d/).map(&:to_i)
    puts "Enter a value"
    value = gets.chomp.scan(/\d/).map(&:to_i)
    [pos, value[0]]
  end


end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
