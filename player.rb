require 'logger'

class Player

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    in_action_id = game_state["in_action"]
    our_player = game_state["players"].detect { |e| e["id"] == in_action_id }
    all_in_baby(our_player)
  end

  def showdown(game_state)

  end

  private


  def all_in_baby(player)
    fat_stack = player["stack"].to_i
    return fat_stack
  end


  def logger
    @_logger ||= Logger.new($stderr)
  end

  # def chen_score(c1, c2)
  #   _score = [ c1, c2 ].map { |e| rv(e) }.max
  # end

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
end
