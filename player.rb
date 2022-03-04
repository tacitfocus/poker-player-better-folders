require 'logger'
require 'json'

require_relative 'chen'
require_relative 'card'
require_relative 'hand'

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

  def fold
    0
  end

  def computer_hand
    case
    when hand.pair?
      all_in_baby
    when hand.high_card >= 12 && hand.gap <= 4
      all_in_baby
    when hand.suited?
      all_in_baby
    else
      fold
    end
  end

  private

  attr_reader :player_data

  def hand
    @_hand ||= Hand.new( *hole_cards )
  end

  def hole_cards
    @_hole_cards ||= player_data["hole_cards"].map { |e| Card.new(e) }
  end

  def stack
    player_data["stack"].to_i
  end

  def logger
    @_logger ||= Logger.new($stderr)
  end
end

