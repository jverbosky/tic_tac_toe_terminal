require_relative "board.rb"

# class for computer player that places mark on next open position
class PlayerSequential

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
  end

  def get_move(game_board, round, mark, wins, x_pos, o_pos)
    position = game_board.index("")
    move = @moves[position]
  end

end

# Sandbox testing
# board = Board.new
# p1 = PlayerSequential.new
# # board.game_board = ["", "", "", "", "X", "", "", "", ""]  # t2
# # board.game_board = ["", "", "", "", "X", "", "O", "", ""]  # t3
# # board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]  # b1
# # board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]  # b2
# puts p1.get_move(board.game_board)