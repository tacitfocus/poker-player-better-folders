class Hand
  def initialize(*cards)
    @cards = cards.flatten
  end

  def pair?
    @cards.map(&:rank).uniq.length == 1
  end

  def suited?
    @cards.map(&:suit).uniq.length == 1
  end

  def gap
    high_card - low_card
  end

  def low_card  ; @cards.map(&:rank).min ; end
  def high_card ; @cards.map(&:rank).max ; end
end
