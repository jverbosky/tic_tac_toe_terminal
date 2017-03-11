require_relative "board.rb"

# class to determine current round and mark by looking at board layout
class Turn

  def initialize

  end

  def get_mark(x_count, o_count)
    x_count > o_count ? "O" : "X"
  end

  def get_round(x_count, o_count)
    x_count + o_count + 1
  end

end

# # Sandbox testing
# board = Board.new
# turn = Turn.new
# # board.game_board = ["", "", "", "", "X", "", "", "", ""]  # O
# # board.game_board = ["", "", "", "", "X", "", "O", "", ""]  # X
# # board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]  # X
# # board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]  # O
# puts "X count: #{board.x_count}"
# puts "O count: #{board.o_count}"
# player = turn.get_player(board.x_count, board.o_count)
# puts "Player: #{player}"
# round = turn.get_round(board.x_count, board.o_count)
# puts "Round: #{round}"