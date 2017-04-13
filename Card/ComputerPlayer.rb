class ComputerPlayer

  def initialize(board)
    @known_cards = {}
    @matched_cards = []
    @guesses = 0
    @board = board
  end

  def first_guess?
    @guesses % 2 == 0
  end

  def prompt
  end

  def get_input
    sleep(0.1)
    @known_matches = unmatched_cards.values.select do |v|
      unmatched_cards.values.map(&:value).count(v.value) == 2
    end
    if @known_matches.empty?
      pos = guess_positions.sample
    else
      match_pair = unmatched_cards.select do |_, v|
        v == @known_matches.first
      end
      if first_guess?
        pos =  match_pair.keys.first
      else
        pos =  match_pair.keys.last
      end
    end

    @guesses += 1
    pos
  end
  def receive_match(pos1, pos2)
    @matched_cards += [pos1, pos2]
  end

  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
  end

  def unmatched_cards
    @known_cards.select do |k, v|
      valid_positions.include?(k)
    end
  end





  def valid_positions
    @board.all_positions.reject do |pos|
      @matched_cards.include?(pos)
    end
  end

  def guess_positions
    valid_positions.reject do |pos|
      @known_cards.keys.include?(pos)
    end
  end


end
