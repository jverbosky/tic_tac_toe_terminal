###################################
# Program for running tic tac toe #
###################################

require_relative "game.rb"

start = Game.new

while $game_over == false
  start.play
end