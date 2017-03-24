###################################
# Program for running tic tac toe #
###################################

# require_relative "game.rb"

# start = Game.new

# while $game_over == false
#   start.play
# end

#-----------------------------------------------------------------------
# Old stress testing code that only displays final game screen (just for reference)
# Loops until game over condition reached - use for stress testing

# require_relative "board.rb"
# require_relative "player_perf.rb"
# require_relative "player_perf_2.rb"
# require_relative "player_perf_3.rb"
# require_relative "player_seq.rb"
# require_relative "player_rand.rb"
# require_relative "position.rb"
# require_relative "console_stress_test.rb"

# # Initialize objects
# board = Board.new
# # p1 = PlayerSequential.new  # alternate p1
# p1_type = "Random"
# p1 = PlayerRandom.new  # alternate p1
# # p1_type = "Perfect"
# # p1 = PlayerPerfect.new
# # p1 = PlayerPerfect2.new
# # p1 = PlayerPerfect3.new
# # p2 = PlayerSequential.new
# # p2_type = "Random"
# # p2 = PlayerRandom.new  # alternate p2
# p2_type = "Perfect"
# # p2 = PlayerPerfect.new  # alternate p2
# # p2 = PlayerPerfect2.new  # alternate p2
# p2 = PlayerPerfect3.new  # alternate p2
# position = Position.new
# console = ConsoleStressTest.new

# # Constant needed by perfect player
# wins = board.wins

# # Endgame condition checks - default to false
# x_won = false
# o_won = false
# full = false

# # Each iteration == 1 (attempted) move
# while x_won == false && o_won == false && full == false
#   round = board.get_round(board.x_count, board.o_count)  # puts round  # see the current round number
#   round % 2 == 0 ? player = p2 : player = p1  # puts player  # see which player moved during this turn
#   round % 2 == 0 ? p_type = p2_type : p_type = p1_type  # puts player  # see which player moved during this turn
#   mark = board.get_mark(board.x_count, board.o_count)  # puts mark  # see which mark was used
#   x_pos = board.get_x
#   o_pos = board.get_o
#   # move = player.get_move(board.game_board, round, mark, wins, x_pos, o_pos)  # puts move  # see what game_board position was selected
#   if p_type == "Perfect"
#     move = player.get_move(wins, x_pos, o_pos, mark)  # use for PerfectPlayer3
#   else
#     move = player.get_move(board.game_board, round, mark, wins, x_pos, o_pos)  # use for PerfectPlayer3
#   end
#   location = position.get_index(move)  # puts location  # see the corresponding game_board array index
#   board.set_position(location, mark)
#   x_won = board.x_won?(board.get_x)  # puts x_won  # see if x won (t/f)
#   o_won = board.o_won?(board.get_o)  # puts o_won  # see if o won (t/f)
#   full = board.board_full?  # puts full # see if the game_board is full (t/f)
# end

# # Console output for game results (board and status)
# console.output_board(board.game_board)
# console.output_results(x_won, o_won)

#-----------------------------------------------------------------------
# New stress testing code that displays game screen for every round
# to determine where logic failing
# Loops until game over condition reached

require_relative "board.rb"
require_relative "player_perf.rb"
require_relative "player_perf_2.rb"
require_relative "player_perf_3.rb"
require_relative "player_seq.rb"
require_relative "player_rand.rb"
require_relative "position.rb"
require_relative "console_stress_test.rb"

# Initialize objects
board = Board.new
# p1 = PlayerSequential.new  # alternate p1
# p1_type = "Random"
# p1 = PlayerRandom.new  # alternate p1
p1_type = "Perfect"
# p1 = PlayerPerfect.new
# p1 = PlayerPerfect2.new
p1 = PlayerPerfect3.new
# p2 = PlayerSequential.new
p2_type = "Random"
p2 = PlayerRandom.new  # alternate p2
# p2_type = "Perfect"
# p2 = PlayerPerfect.new  # alternate p2
# p2 = PlayerPerfect2.new  # alternate p2
# p2 = PlayerPerfect3.new  # alternate p2
position = Position.new
console = ConsoleStressTest.new

# Constant needed by perfect player
wins = board.wins

# Endgame condition checks - default to false
x_won = false
o_won = false
full = false

# Method to allow console output to be more specified concisely
def tab(n, *string)
  string.each_with_index { |e, i| i == 0 ? (puts " " * n + e) : (puts e) }
end

# Each iteration == 1 (attempted) move
while x_won == false && o_won == false && full == false
  round = board.get_round(board.x_count, board.o_count)  # puts round  # see the current round number
  round % 2 == 0 ? player = p2 : player = p1  # puts player  # see which player moved during this turn
  round % 2 == 0 ? p_type = p2_type : p_type = p1_type  # puts player  # see which player moved during this turn
  mark = board.get_mark(board.x_count, board.o_count)  # puts mark  # see which mark was used
  x_pos = board.get_x
  o_pos = board.get_o
  # move = player.get_move(board.game_board, round, mark, wins, x_pos, o_pos)  # puts move  # see what game_board position was selected
  if p_type == "Perfect"
    move = player.get_move(wins, x_pos, o_pos, mark)  # use for PerfectPlayer3
  else
    move = player.get_move(board.game_board, round, mark, wins, x_pos, o_pos)  # use for PerfectPlayer3
  end
  location = position.get_index(move)  # puts location  # see the corresponding game_board array index
  board.set_position(location, mark)
  x_won = board.x_won?(board.get_x)  # puts x_won  # see if x won (t/f)
  o_won = board.o_won?(board.get_o)  # puts o_won  # see if o won (t/f)
  full = board.board_full?  # puts full # see if the game_board is full (t/f)
  puts "\n"
  spaced = []
  board.game_board.each { |mark| mark == "" ? spaced.push(" ") : spaced.push(mark) }
  rows = spaced.each_slice(3).to_a
  rows.each_with_index do |row, index|
    # index < 2 ? (tab(11, row.join(" | ")); tab(11, "-" * 9)) : tab(11, row.join(" | "))
    index < 2 ? (tab(0, row.join(" | ")); tab(0, "-" * 9)) : tab(0, row.join(" | "))
  end
  puts "\n"
end

# Console output for game results (board and status)
console.output_results(x_won, o_won)