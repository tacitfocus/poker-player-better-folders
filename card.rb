class Card

  RANKS = {
    "T" => 10,
    "J" => 11,
    "Q" => 12,
    "K" => 13,
    "A" => 14,
  }

  def self.rank_value(x)
    RANKS.fetch(x) { x.to_i }
  end



  def initialize(json_data)
    @json_data = json_data
  end

  def suit
    @json_data["suit"]
  end

  def rank
    self.class.rank_value( @json_data["rank"] )
  end

end
