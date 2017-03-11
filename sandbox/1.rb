# Sandbox testing:
# game_board = ["", "", "", "", "", "", "", "", ""]  # X
# game_board = ["", "", "", "", "X", "", "", "", ""]  # O
# game_board = ["", "", "", "", "X", "", "O", "", ""]  # X
# game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]  # X
game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]  # O

# player_1 = "X"
# player_2 = "O"

# x_count = game_board.count("X")
# o_count = game_board.count("O")

# turn = ""

def get_player(game_board)
  x_count = game_board.count("X")
  o_count = game_board.count("O")
  x_count > o_count ? "O" : "X"
end

print get_player(game_board)

# player_1 = "X"
# player_2 = "O"

# turn = player_1

# if game_board.count("") == 9
#   turn = player_1
# elsif game_board.count("X") > game_board.count("O")
#   turn = player_2
# elsif game_board.count("X") == game_board.count("O")
#   turn = player_1
# end