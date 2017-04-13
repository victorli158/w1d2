require_relative "Tile.rb"
require "byebug"

class Board

  def self.from_file(file)
    grid = []
    File.foreach(file) do |line|
      row = line.scan(/\d/).map(&:to_i)
      tile_row = []
      row.each do |num|
        tile_row << Tile.new(num)
      end
      grid << tile_row
    end
    self.new(grid)
  end

attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def render
    @grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        print tile.to_s
        print vertical_bars(j)
      end
      print ("\n")
      print horizontal_bars(i)

    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col].value
  end

  def []=(pos,value)
    row, col = pos
    @grid[row][col].value = value
  end

  def vertical_bars(j)
    ("|") if (j + 1) % 3 == 0
  end

  def horizontal_bars(i)
    "-" * 12 + "\n" if (i + 1) % 3 == 0
  end

  def solved?
    check_rows(@grid) && check_rows(transpose_grid) && check_boxes
  end

  def transpose_grid
    column_grid = []
    (0..8).each do |col|
      column = []
      @grid.each do |row|
        column << row[col]
      end
      column_grid << column
    end
    column_grid
  end

  def check_rows(rows)
    rows.all? do |row|
      check_array(row)
    end
  end

  def check_boxes
    ranges = [[0, 2], [3, 5], [6, 8]]
    array = []
    ranges.each do |row_range|
      ranges.each do |col_range|
        array << build_array(row_range,col_range)
      end
    end
    check_rows(array)
  end

  def build_array(row_range, col_range)
    array = []
    (row_range.first..row_range.last).each do |row|
      (col_range.first..col_range.last).each do |col|
        array << @grid[row][col]
      end
    end
    array
  end

  def check_array(array)
    check = array.map(&:value).uniq
    check.select! { |tile| (1..9).include?(tile) }
    check.length == 9
  end

  def valid?(pos)
    return false if @grid[pos[0]][pos[1]].given == true
    return false if pos.any? { |el| el < 0 || el > 8 }
    true
  end

end
