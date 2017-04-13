require 'byebug'

class Card
  attr_reader :value, :face_up

  def initialize(value)
    @value = value
    @face_up = false
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def ==(card)
    @value == card.value
  end

  def to_s
    if @face_up
      string = @value
    else
      string = "?" * @value.length
    end
    string
  end

end
