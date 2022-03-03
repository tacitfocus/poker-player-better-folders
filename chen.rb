=begin
function Chen(C 1 , C 2 )
    score := Max(rv(C 1 ), rv(C 2 ))
    if Csuit(C 1 ) == Csuit(C 2 ) then score := score + 2
    end if

    gap := |Cvalue(C 1 ) == Cvalue(C 2 )|
    if gap = 0 then score := score×2
    else if gap = 1 then score := score+1
    else if gap = 2 then score := score-1
    else if gap = 3 then score := score-2
    else if gap = 4 then score := score-4
    else score := score – 5 end if
return score / 20
=end

module Chen
  extend self

  RANKS = {
    "T" => 10,
    "J" => 11,
    "Q" => 12,
    "K" => 13,
    "A" => 14,
  }

  def rank_value(x)
    RANKS.fetch(x) { x.to_i }
  end

  CHEN_RANKS = {
    "T" => 5,
    "J" => 6,
    "Q" => 7,
    "K" => 8,
    "A" => 10,
  }

  def chen_value(x)
    CHEN_RANKS.fetch(x) { x.to_i / 2 }
  end

  def gap(a, b)
    x, y = [ a, b ].map { |e| rank_value(e) }
    (x-y).abs
  end

  def same_suit?(suit1, suit2)
    suit1 == suit2
  end

end

