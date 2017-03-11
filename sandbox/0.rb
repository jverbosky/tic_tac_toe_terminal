# game_board = ["", "", "", "", "", "", "", "", ""]
# game_board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

# 0 1 2
# 3 4 5
# 6 7 8

# horizontal wins
# 0 1 2 - 3 4 5 - 6 7 8
#
# O O O   O X O     X X
# X O X   X X X   X O X
# X X     O O     O O O

# vertical wins
# 0 3 6 - 1 4 7 - 2 5 8
#
# X O O   X O X   O O X
# X X O     O X   O   X
# X O     X O O   X O X

# diagonal wins
# 0 4 8 - 2 4 6
#
# O X X   O O X
#   O X   O X
# X O O   X O X

wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

# Sandbox tests
# game_board = ["O", "O", "O", "X", "O", "X", "X", "X", ""]  # O win - 0, 1, 2
# game_board = ["O", "X", "O", "X", "X", "X", "O", "O", ""]  # X win - 3, 4, 5
# game_board = ["", "X", "X", "X", "O", "X", "O", "O", "O"]  # O win - 6, 7 ,8
# game_board = ["X", "O", "O", "X", "X", "O", "X", "O", ""]  # X win - 0, 3, 6
# game_board = ["X", "O", "X", "", "O", "X", "X", "O", "O"]  # O win - 1, 4, 7
game_board = ["O", "O", "X", "O", "", "X", "X", "O", "X"]  # X win - 2, 5, 8
# game_board = ["O", "X", "X", "", "O", "X", "X", "O", "O"]  # O win - 0, 4, 8
# game_board = ["O", "O", "X", "O", "X", "", "X", "O", "X"]  # X win - 2, 4, 6

# Output array positions that match marks
o = game_board.each_index.select { |position| game_board[position] == "O" }
x = game_board.each_index.select { |position| game_board[position] == "X" }

p o  # [0, 1, 2] - winner
p x  # [3, 5, 6] - not a winner

def game_won?(current_positions)
  wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  won = false
  wins.each { |win| won = true if current_positions & win == win }
  return won
end

p game_won?(x)
p game_won?(o)