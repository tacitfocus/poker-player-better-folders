class Hand
  def initialize(*cards)
    @cards = cards.flatten
  end

  def pair?
    ranks.uniq.length == 1
  end

  def suited?
    suits.uniq.length == 1
  end

  def gap
    high_card - low_card
  end

  def low_card  ; ranks.min ; end
  def high_card ; ranks.max ; end

  def ranks ; @cards.map(&:rank) ; end
  def suits ; @cards.map(&:suit) ; end
end
