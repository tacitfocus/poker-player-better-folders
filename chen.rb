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

class Chen

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

end

