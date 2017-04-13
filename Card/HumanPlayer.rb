class HumanPlayer

  def initialize(board)
    @board = board
  end

  def prompt
    puts "Make a guess."
  end

  def get_input
    pos = gets.chomp.scan(/\d+/).map(&:to_i)
    while pos.any? { |el| el >= @board.size }
      puts "PICK AGAIN, must be less than #{@board.size}"
      pos = gets.chomp.scan(/\d+/).map(&:to_i)
    end
    pos
  end

  def receive_revealed_card(pos, value)
  end

  def receive_match(pos1, pos2)
  end

end
