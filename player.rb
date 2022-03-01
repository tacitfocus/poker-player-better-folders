require 'logger'

class Player

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    logger.info game_state.to_s
    1_000 - 5
  end

  def showdown(game_state)

  end

  private

  def logger
    @_logger ||= Logger.new($stderr)
  end
end
