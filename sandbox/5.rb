#-----------------------------------------------------------------------------
# Corner Logic
#-----------------------------------------------------------------------------
# Variation 1:
# - O takes opposite corner in round 2, forced to block on edge in round 4
# - X takes last open corner in round 5 for two paths to win
#
#   X - -     X - -     X - X     X O X     X O X
#   - - -  >  - - -  >  - - -  >  - - -  >  - - -
#   - - -     - - O     - - O     - - O     X - O
#-----------------------------------------------------------------------------
# Variation 2:
# - O takes non-opposite corner in round 2, forced to block in middle in round 4
# - X takes last open corner in round 5 for two paths to win
#
#   X - -     X - O     X - O     X - O     X - O
#   - - -  >  - - -  >  - - -  >  - O -  >  - O -
#   - - -     - - -     - - X     - - X     X - X
#-----------------------------------------------------------------------------
# Variation 3: O takes center in round 2, then takes an open corner in round 4
# - X takes last open corner in round 5 for two paths to win
#
#   X - -     X - -     X - -     X - -     X - X
#   - - -  >  - O -  >  - O -  >  - O -  >  - O -
#   - - -     - - -     - - X     O - X     O - X
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Edge Logic
#-----------------------------------------------------------------------------
# - O takes an edge in round 2, has to block with a corner in round 4
# - X takes a specific corner for two paths to win
# - Need to consider non-winning and winning variations
#-----------------------------------------------------------------------------
# Variation 1:
# - Non-winning O edge top (example)
#
#   X - -     X O -     X O -     X O -     X O -
#   - - -  >  - - -  >  - X -  >  - X -  >  - X -
#   - - -     - - -     - - -     - - O     X - O
#-----------------------------------------------------------------------------
# Variation 2:
# - Non-winning O edge middle (example)
#
#   X - -     X - -     X - -     X - -     X - X
#   - - -  >  O - -  >  O X -  >  O X -  >  O X -
#   - - -     - - -     - - -     - - O     - - O
#-----------------------------------------------------------------------------
# Variation 3:
# - Winning O edge middle (example)
#
#   X - -     X - -     X - -     X - -     X - X
#   - - -  >  - - O  >  - X O  >  - X O  >  - X O
#   - - -     - - -     - - -     - - O     - - O
#-----------------------------------------------------------------------------
# Variation 4:
# - Winning O edge bottom (example)
#
#   X - -     X - -     X - -     X - -     X - -
#   - - -  >  - - -  >  - X -  >  - X -  >  - X -
#   - - -     - O -     - O -     - O O     X O O
#-----------------------------------------------------------------------------

# Test using sides to detect adjacent Os for handling round 5 non-perfect player
# O took edge in round 2 and corner in round 4
# Need to split logic between non-adjacent and adjacent Os (compare opponent positions against sides)

sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]
corners = [0, 2, 6, 8]
opcor_1 = [0, 8]  # opposite corners set 1
opcor_2 = [2, 6]  # opposite corners set 2
#-------------------------------------------------------
# board.game_board = ["X", "O", "", "", "X", "", "", "", "O"]  # round 5 - O took corner after edge v1 (b1)

#   X - -     X O -     X O -     X O -     X O -
#   - - -  >  - - -  >  - X -  >  - X -  >  - X -
#   - - -     - - -     - - -     - - O     X - O
opponent = [1, 8]
player = [0, 4]
# side_index = 0
#-------------------------------------------------------
# board.game_board = ["X", "", "", "O", "X", "", "", "", "O"]  # round 5 - O took corner after edge v2 (t3)
#   X - -     X - -     X - -     X - -     X - X
#   - - -  >  O - -  >  O X -  >  O X -  >  O X -
#   - - -     - - -     - - -     - - O     - - O
# opponent = [3, 8]
# player = [0, 4]
# side_index = 3
#-------------------------------------------------------

# Logic
# want to take corner that is opposite the empty corner that is in the side with adjacent marks
# 1) identify side with adjacent marks
# 2) determine empty corner in side from step 1
#    - different logic than what's in o_corner ()
#    - need to calculate based on side evaluation
# 3) determine opposite corner and take it
#    - slightly different logic already in o_corner (final elsif and else statements)
#      - use refcor to calculate instead of player
#    - duplicate and if it works then break out into separate method or rearrange so this method can use

# open_corners = corners - ((player + opponent) & corners)
# p open_corners  # [2, 6]

# 1) identify side with adjacent marks (clockwise - top = 0, right = 1, bottom = 2, left = 3)
side_index = 0
sides.each_with_index { |side, s_index| side_index = s_index if ((player + opponent) & side).count > 1 }
# p side_index

# 2) determine empty corner in side from step 1
# p (player + opponent) & sides[side_index]  # [0, 1]
refcor = sides[side_index] - ((player + opponent) & sides[side_index])  # reference corner in side with adjacent marks [2]

# 3) determine opposite corner and that's what we want
if (opcor_1 - refcor).size == 1
  position = (opcor_1 - refcor)[0]
else
  position = (opcor_2 - refcor)[0]
end

p position

# board.game_board = ["X", "", "", "", "X", "O", "", "", "O"]  # round 5 - O took corner after edge v3 (t3)

#   X - -     X - -     X - -     X - -     X - X
#   - - -  >  - - O  >  - X O  >  - X O  >  - X O
#   - - -     - - -     - - -     - - O     - - O
# opponent = [5, 8]
# player = [0, 4]
#-------------------------------------------------------
# board.game_board = ["X", "", "", "", "X", "", "", "O", "O"]  # round 5 - O took corner after edge v4 (b1)

#   X - -     X - -     X - -     X - -     X - -
#   - - -  >  - - -  >  - X -  >  - X -  >  - X -
#   - - -     - O -     - O -     - O O     X O O
# opponent = [7, 8]
# player = [0, 4]
#-------------------------------------------------------

adjacent_o = 0

sides.each do |side|
  if (side & opponent).count == 2
    adjacent_o += 1
  end
end

# p adjacent_o
# v1 = 0  # no adjacent Os
# v2 = 0  # no adjacent Os
# v3 = 1  # adjacent Os
# v3 = 1  # adjacent Os