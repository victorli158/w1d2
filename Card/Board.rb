require_relative "Card.rb"

class Board

  def default_grid
    Array.new(8) { Array.new(8) }
  end

  def initialize(grid = self.default_grid)
    @grid = grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def render
    @grid.each do |row|
      row.each do |card|
        print card.to_s
      end
      print "\n"
    end
  end

  def populate
    number_of_cards.times do |num|
      2.times do
        self[get_empty_pos] = Card.new(card_values[num%26] * (num/26+1))
      end
    end
  end

  def get_empty_pos
    pos = [rand(size), rand(size)]
    until self[pos].nil?
      pos = [rand(size), rand(size)]
    end
    pos
  end

  def size
    @grid.length
  end

  def number_of_cards
    (size**2) / 2
  end

  def card_values
    ("a".."z").to_a[0, number_of_cards]
  end

  def reveal(guessed_pos)
    self[guessed_pos].reveal
    self[guessed_pos].value
  end

  def won?
    @grid.flatten.none? { |card| card.to_s == "?" }
  end

  def all_positions
    all_array = []
    (0...size).each do |row|
      (0...size).each do |col|
        all_array << [row, col]
      end
    end
    all_array
  end

end
