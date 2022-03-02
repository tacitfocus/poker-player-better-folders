require 'logger'
require 'json'

require_relative 'chen'

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


  def all_in_baby(player_data)
    fat_stack = player_data["stack"].to_i
    return fat_stack
  end

  def score_hand_v1(player_data)
    player_data["hole_cards"].map { |e| Chen.new.rank_value(e["rank"]) }.max
  end

  private



  def logger
    @_logger ||= Logger.new($stderr)
  end
end

