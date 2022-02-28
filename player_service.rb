require 'sinatra'
require 'json'
require_relative 'player'

require 'logger'

set :port, ENV["PORT"]
set :bind, '0.0.0.0'

logger = Logger.new($stderr)

get '/' do
  logger.warn 'hello, stderr'
  'wibble'
end

post "/" do
  if params[:action] == 'bet_request'
    Player.new.bet_request(JSON.parse(params[:game_state])).to_s
  elsif params[:action] == 'showdown'
    Player.new.showdown(JSON.parse(params[:game_state]))
    'OK'
  elsif params[:action] == 'version'
    Player::VERSION
  else
    'OK'
  end
end
