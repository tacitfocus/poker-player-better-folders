require 'logger'

class Player

  VERSION = "Default Ruby folding player"

  CURRENT_STRATEGY = :all_in_baby

  def bet_request(game_state)
    in_action_id = game_state["in_action"]
    our_player = game_state["players"].detect { |e| e["id"] == in_action_id }
    send CURRENT_STRATEGY, our_player
  rescue StandardError => e
    logger.fatal e.class.to_s + "  " + e.message + "  " + e.backtrace[0..3]
    0
  end

  def showdown(game_state)

  end


  def all_in_baby(player)
    fat_stack = player["stack"].to_i
    return fat_stack
  end

  private



  def logger
    @_logger ||= Logger.new($stderr)
  end
end

