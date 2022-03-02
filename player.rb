require 'logger'
require 'json'

require_relative 'chen'

class Player

  VERSION = "Default Ruby folding player"

  CURRENT_STRATEGY = :computer_hand

  def bet_request(game_state)
    in_action_id = game_state["in_action"]
    @player_data = game_state["players"].detect { |e| e["id"] == in_action_id }
    send CURRENT_STRATEGY
  rescue StandardError => e
    logger.fatal e.class.to_s + "  " + e.message + "  " + e.backtrace[0..3]
    0
  end

  def showdown(game_state)
  end


  def all_in_baby
    fat_stack = player_data["stack"].to_i
    return fat_stack
  end

  def high_card_or_fold
    high_card = score_hand_v1(player_data)
    if high_card >= 12
      all_in_baby(player_data)
    else
      0
    end
  end

  def computer_hand
    the_gap = Chen.gap( *hole_cards.map { |e| e["rank"] } )
    return stack if the_gap.zero?

    high_card_or_fold # temporarily

    # high_card = score_hand_v1(player_data)
    # if high_card >= 12
    #   all_in_baby(player_data)
    # else
    #   0
    # end
  end

  def score_hand_v1
    hole_cards.map { |e| Chen.rank_value(e["rank"]) }.max
  end

  private

  attr_reader :player_data

  def hole_cards
    player_data["hole_cards"]
  end

  def stack
    player_data["stack"].to_i
  end

  def logger
    @_logger ||= Logger.new($stderr)
  end
end

