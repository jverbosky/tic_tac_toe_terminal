require_relative "board.rb"

# class to determine if game was won
class Win

  def initialize
    @wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  end

  def game_won?(positions)
    won = false
    @wins.each { |win| won = true if positions & win == win }
    won
  end

  def x_won?(get_x)
    positions = get_x
    game_won?(positions)
  end

  def o_won?(get_o)
    positions = get_o
    game_won?(positions)
  end

end

# Sandbox testing:
# board = Board.new
# win = Win.new
# # board.game_board = ["", "X", "", "O", "X", "", "O", "", "X"]  # false
# # board.game_board = ["O", "O", "X", "O", "", "X", "X", "O", "X"]  # true - X
# # board.game_board = ["", "X", "", "O", "X", "", "O", "", "X"]  # false
# # board.game_board = ["O", "X", "X", "", "O", "X", "X", "O", "O"]  # true - O
# puts win.x_won?(board.get_x)
# puts win.game_won?(board.get_x)
# puts win.o_won?(board.get_o)
# puts win.game_won?(board.get_o)