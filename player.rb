require 'logger'
require 'json'

require_relative 'chen'
require_relative 'card'

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
    return stack
  end

  def high_card_or_fold
    high_card = score_hand_v1
    if high_card >= 12
      all_in_baby
    else
      0
    end
  end

  def computer_hand
    gap = Chen.gap( *hole_cards.map { |e| e["rank"] } )
    return stack if gap.zero?

    high_card = score_hand_v1
    case
    when high_card >= 12 && gap <= 5
      all_in_baby
    when Chen.same_suit?( *hole_cards.map { |e| e["suit"] } )
      all_in_baby
    else
      0
    end
  end

  def score_hand_v1
    hole_cards.map { |e| Card.rank_value(e["rank"]) }.max
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

