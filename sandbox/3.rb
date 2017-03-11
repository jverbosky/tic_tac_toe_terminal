require_relative "../board.rb"
# --------------------------------------------------------------------
# board = ["", "", "", "", "", "", "", "", ""]
# board_index = [0, 1, 2, 3, 4, 5, 6, 7, 8]
# --------------------------------------------------------------------
# Board positions after round 3
# --------------------------------------------------------------------
# X - -
# - O -   # variation 1
# - - X
# --------------------------------------------------------------------
# Block when only 1 potentially winning position
round_4 = ["X", "", "", "", "O", "", "", "", "X"]  # variation 1 - O takes edge at 
# round_4 = ["X", "", "", "", "O", "", "", "", "X"]  # variation 2 - O takes edge at 
# round_4 = ["X", "", "", "", "O", "", "", "", "X"]  # variation 3 - O takes edge at 
# round_4 = ["X", "", "", "", "O", "", "", "", "X"]  # variation 4 - O takes edge at 
# round_4 = ["", "", "X", "", "O", "", "X", "", ""]  # variation 5 - O takes edge at 
# round_4 = ["", "", "X", "", "O", "", "X", "", ""]  # variation 6 - O takes edge at 
# round_4 = ["", "", "X", "", "O", "", "X", "", ""]  # variation 7 - O takes edge at 
# round_4 = ["", "", "X", "", "O", "", "X", "", ""]  # variation 8 - O takes edge at 
# --------------------------------------------------------------------
# Board positions after round 4
# --------------------------------------------------------------------
# X O -
# - O -   # variation 1
# - - X
# --------------------------------------------------------------------
# Block when only 1 potentially winning position
# round_5 = ["X", "O", "", "", "O", "", "", "", "X"]  # variation 1 - X blocks O at 7
# round_5 = ["X", "", "", "O", "O", "", "", "", "X"]  # variation 2 - X blocks O at 5
# round_5 = ["X", "", "", "", "O", "O", "", "", "X"]  # variation 3 - X blocks O at 3
# round_5 = ["X", "", "", "", "O", "", "", "O", "X"]  # variation 4 - X blocks O at 1
# round_5 = ["", "O", "X", "", "O", "", "X", "", ""]  # variation 5 - X blocks O at 7
# round_5 = ["", "", "X", "O", "O", "", "X", "", ""]  # variation 6 - X blocks O at 5
# round_5 = ["", "", "X", "", "O", "O", "X", "", ""]  # variation 7 - X blocks O at 3
# round_5 = ["", "", "X", "", "O", "", "X", "O", ""]  # variation 8 - X blocks O at 1
# --------------------------------------------------------------------
# Board positions after round 5
# --------------------------------------------------------------------
# X O -
# - O -   # variation 1
# - X X
# --------------------------------------------------------------------
# Block when 2 potentially winning positions (1 already taken by O)
# round_6 = ["X", "O", "", "", "O", "", "", "X", "X"]  # variation 1 - O blocks X at 6
# round_6 = ["X", "", "", "O", "O", "X", "", "", "X"]  # variation 2 - O blocks X at 2
# round_6 = ["X", "", "", "X", "O", "O", "", "", "X"]  # variation 3 - O blocks X at 6
# round_6 = ["X", "X", "", "", "O", "", "", "O", "X"]  # variation 4 - O blocks X at 2
# round_6 = ["", "O", "X", "", "O", "", "X", "X", ""]  # variation 5 - O blocks X at 8
# round_6 = ["", "", "X", "O", "O", "X", "X", "", ""]  # variation 6 - O blocks X at 8
# round_6 = ["", "", "X", "X", "O", "O", "X", "", ""]  # variation 7 - O blocks X at 0
# round_6 = ["", "X", "X", "", "O", "", "X", "O", ""]  # variation 8 - O blocks X at 0
# --------------------------------------------------------------------
# Board positions after round 6
# --------------------------------------------------------------------
# X O -
# - O -   # variation 1
# O X X
# --------------------------------------------------------------------
# Block when 2 potentially winning positions (1 already taken by X)
# round_7 = ["X", "O", "", "", "O", "", "O", "X", "X"]  # variation 1 - X blocks O at 2
# round_7 = ["X", "", "O", "O", "O", "X", "", "", "X"]  # variation 2 - X blocks O at 6
# round_7 = ["X", "", "", "X", "O", "O", "O", "", "X"]  # variation 3 - X blocks O at 2
# round_7 = ["X", "X", "O", "", "O", "", "", "O", "X"]  # variation 4 - X blocks O at 6
# round_7 = ["", "O", "X", "", "O", "", "X", "X", "O"]  # variation 5 - X blocks O at 0
# round_7 = ["", "", "X", "O", "O", "X", "X", "", "O"]  # variation 6 - X blocks O at 0
# round_7 = ["O", "", "X", "X", "O", "O", "X", "", ""]  # variation 7 - X blocks O at 8
# round_7 = ["O", "", "X", "", "O", "", "X", "O", ""]  # variation 8 - X blocks O at 1
# --------------------------------------------------------------------
# Board positions after round 7
# --------------------------------------------------------------------
# X O X                        # O X X
# - O -   # variation 1        # - O -   # variation 8 (nothing to block)
# O X X                        # X O -
# --------------------------------------------------------------------
# Block when 3 potentially winning positions (2 already taken by O)
# round_8 = ["X", "O", "X", "", "O", "", "O", "X", "X"]  # variation 1 - O blocks X at 5
# round_8 = ["X", "", "O", "O", "O", "X", "X", "", "X"]  # variation 2 - O blocks X at 7
# round_8 = ["X", "", "X", "X", "O", "O", "O", "", "X"]  # variation 3 - O blocks X at 1
# round_8 = ["X", "X", "O", "", "O", "", "X", "O", "X"]  # variation 4 - O blocks X at 3
# round_8 = ["X", "O", "X", "", "O", "", "X", "X", "O"]  # variation 5 - O blocks X at 3
# round_8 = ["X", "", "X", "O", "O", "X", "X", "", "O"]  # variation 6 - O blocks X at 1
# round_8 = ["O", "", "X", "X", "O", "O", "X", "", "X"]  # variation 7 - O blocks X at 7
round_8 = ["O", "X", "X", "", "O", "", "X", "O", ""]  # variation 8 - O wins at 8
# --------------------------------------------------------------------
# Board positions after round 8
# --------------------------------------------------------------------
# X O X                        # O X X
# - O -   # variation 1        # - O -   # variation 8 (nothing to block)
# O X X                        # X O O
# --------------------------------------------------------------------
# Block when 3 potentially winning positions (2 already taken by O)
round_9 = ["X", "O", "X", "", "O", "", "O", "X", "X"]  # variation 1 - X wins at 5
# round_9 = ["X", "", "O", "O", "O", "X", "X", "", "X"]  # variation 2 - X wins at 7
# round_9 = ["X", "", "X", "X", "O", "O", "O", "", "X"]  # variation 3 - X wins at 1
# round_9 = ["X", "X", "O", "", "O", "", "X", "O", "X"]  # variation 4 - X wins at 3
# round_9 = ["X", "O", "X", "", "O", "", "X", "X", "O"]  # variation 5 - X wins at 3
# round_9 = ["X", "", "X", "O", "O", "X", "X", "", "O"]  # variation 6 - X wins at 1
# round_9 = ["O", "", "X", "X", "O", "O", "X", "", "X"]  # variation 7 - X wins at 7
# round_9 = ["O", "X", "X", "", "O", "", "X", "O", "O"]  # variation 8 - game over
# --------------------------------------------------------------------
# Multiple possible blocks
# --------------------------------------------------------------------
# O O -
# X O X
# X - -
# --------------------------------------------------------------------
round_b = ["O", "O", "", "X", "O", "X", "X", "", ""]   # X blocks O at 2, 7 or 8
# --------------------------------------------------------------------
# Multiple possible wins
# --------------------------------------------------------------------
# X X -
# O X O
# O - -
# --------------------------------------------------------------------
round_w = ["X", "X", "", "O", "X", "O", "O", "", ""]   # X wins at 2, 7 or 8
# --------------------------------------------------------------------
# Multiple possible moves (non-winning/non-blocking)
# - develop for non-perfect opening moves
# - also needed for endgame
# --------------------------------------------------------------------
# X - -                        # O X -
# - - O   # variation 1        # - X O   # variation 2 (non-perfect round 7)
# O X -                        # - O X
# --------------------------------------------------------------------
# round_n = ["X", "", "", "", "", "O", "O", "X", ""]   # variation 1 - X will take 1, 2, 3, 4 or 8
round_n = ["O", "X", "", "", "X", "O", "", "O", "X"]   # variation 2 - X will take 2, 3 or 6
# --------------------------------------------------------------------

wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

board = Board.new
board.game_board = round_n  # change round number to test different board layouts

x_pos = board.get_x
o_pos = board.get_o
# p x_pos
# p o_pos

# Method to handle x logic for opening rounds
def opening_x(round, x_pos)
  position = false
  case round
    when 1 then position = [0, 2, 6, 8].sample  # take a corner
    when 3 then  # take the opposite corner
      case x_pos
        when [0] then position = 8
        when [2] then position = 6
        when [6] then position = 2
        when [8] then position = 0
      end
  end
  position
end

# Method to handle o logic for opening rounds
def opening_o(round)
  position = false
  case round
    when 2 then position = 4  # take the center
    when 4 then position = [1, 3, 5, 7].sample  # take an edge
  end
  position
end

# Method to return position to win, false if none
def move(wins, player, opponent)
  position = []
  wins.each do |win|
    difference = win - player  # difference between current win array and player position array
    if difference.count == 1  # if player 1 move from win, take position unless already opponent mark
      position.push(difference[0]) unless (opponent & difference).count == 1
    end
  end
  if position.count == 0  # if nothing to block or win, randomly collect an open position
    position.push((Array(0..8) - (player + opponent)).sample)
  end
  position.sample  # .sample in case of multiple
end

# Method to return position to block, call win() if nothing to block
def block(wins, player, opponent)
  position = []
  wins.each do |win|
    difference = win - opponent  # difference between current win array and opponent position array
    if difference.count == 1  # if opponent 1 move from win, block position unless already player mark
      position.push(difference[0]) unless (player & difference).count == 1
    end
  end
  position.count > 0 ? position.sample : move(wins, player, opponent)  # .sample in case of multiple
end

# p block(wins, o_pos, x_pos)  # O blocking X (round 6 - working, round 8 - working)
p block(wins, x_pos, o_pos)  # X blocking O (round 5 - working, round 7 - working, round 9 - )

# --------------------------------------------------------------------
# Historical Block Variations (here for reference)
# --------------------------------------------------------------------

# Round 5 - only 1 spot to block
# def block_o(wins, x_pos, o_pos) # pos of player to block
#   block = []
#   wins.each { |win| block = win - o_pos if (win - o_pos).count == 1 }
#   block
# end

# Round 6 - block X
# def block_x(wins, o_pos, x_pos)
#   block = []
#   wins.each do |win|
#     if (win - x_pos).count == 1  # if X is 1 move away from a win
#         block.push((win - x_pos)[0])
#         block.pop if (o_pos & block).count == 1
#     end
#   end
#   block  # [6]
# end

# X O -
# - O -
# - X X

# win_1 = [0, 4, 8] # O at 4
# win_2 = [6, 7, 8] # nobody at 6
# x_pos = [0, 7, 8]
# o_pos = [1, 4]
# block = [4]

# if o_pos & block == block

# Compare current X position against winning position
# x_pos = [0, 6]
# win = [0, 3, 6]
# block = win - x_pos  # [0, 3, 6] - [0, 6]
# puts block  # 3

# --------------------------------------------------------------------
# Strategy notes
# --------------------------------------------------------------------

# X
# ____________________________

# 1) Take a corner [0, 2, 6, 8]

# 2) Take opposite corner
#   - if 0 then 8
#   - if 2 then 6
#   - if 6 then 2
#   - if 8 then 0

# 3 - end) Block

# ____________________________

# O
# ____________________________

# 1) Take center [4]

# 2) Take an edge [1, 3, 5, 7]

# 3 - end) Block
# ____________________________
