require 'colorize'

String.disable_colorization = false

class Tile
  attr_accessor :value
  attr_reader :given

  def initialize(value)
    @value = value
    @given = value != 0
  end

  def to_s
    if @given
      @value.to_s.colorize(:blue).underline
    else
      @value.to_s.colorize(:black)
    end
  end

end
