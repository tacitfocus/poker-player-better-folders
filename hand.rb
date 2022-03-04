class Hand
  def initialize(*cards)
    @cards = cards.flatten
  end

  def pair?
    @cards.map(&:rank).uniq.length == 1
  end

  def gap
    lo, hi = *@cards.map(&:rank).minmax
    hi - lo
  end
end
