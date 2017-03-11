# Refactoring edg_cor (now: sel_adj_edg)

# board.game_board = ["X", "", "", "", "O", "", "", "X", ""]  # X took corner and non-adjacent edge, O takes edge opposite corner v1 (m3) 67
# board.game_board = ["X", "", "", "", "O", "X", "", "", ""]  # X took corner and non-adjacent edge, O takes edge opposite corner v2 (b2) 68

# X - -   - - X
# - O -   X O -
# - X -   - - -

# have O take other member of adj_edge pair opposite to corner X

@opcor_1 = [0, 8]  # opposite corners - set 1
@opcor_2 = [2, 6]  # opposite corners - set 2

def sel_op_cor(corner)
  # if @opcor_1 and corner differ by 1 opposite corner is in @opcor_1, otherwise its in @opcor_2
  (@opcor_1 - corner).size == 1 ? position = (@opcor_1 - corner)[0] : position = (@opcor_2 - corner)[0]
end

# corners = [0, 2, 6, 8]
# edges = [1, 3, 5, 7]
# adjedg = [[5, 7], [3, 7], [1, 5], [1, 3]]

# player = [4]
# opponent = [0, 7]
# # player = [4]
# # opponent = [2, 3]

# taken_edge = opponent & edges
# taken_corner = opponent & corners  # corners taken by opponent
# cor_index = corners.index(taken_corner[0])
# adjedg_pair = adjedg[cor_index]
# position = (adjedg_pair - taken_edge)[0]

# p taken_edge
# p taken_corner
# p cor_index
# p adjedg_pair
# p position

#-----------------------------------------------------------

# Refactor edge_logic (used by tests 18 & 19 in Round 5)
# - messy selection (fallthrough logic instead of pattern matching)

#  11      12      13      14      15      16      17      20      21      22      23      24
# X O -   X - -   X - -   X - -   X - O   X O X   X - -   X - -   X - -   X - X   - - O   X - O
# - O -   O O -   - O O   - O -   - O -   - - -   - O -   - X O   - X -   - - -   O X -   O X -
# - - X   - - X   - - X   - O X   - - X   - - O   O - X   - - O   - O O   O - O   - - X   - - -

# X O -   X - -
# - X -   O X -  18 (b1) & 19 (t3)
# - - O   - - O



# 1) If X corner has adjacent O edge
# 2) If O in opposite corner
# 3) If X in center

center = [4]
corners = [0, 2, 6, 8]
cor_edg = [[3, 0, 1], [1, 2, 5], [5, 8, 7], [7, 6, 3]]
sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]

player = [0, 4]      # 18
opponent = [3, 8]
# player = [0, 4]      # 19
# opponent = [1, 8]
# player = [0, 8]      # 11
# opponent = [1, 4]
# player = [0, 8]      # 12
# opponent = [3, 4]
# player = [0, 8]      # 13
# opponent = [4, 5]
# player = [0, 8]      # 14
# opponent = [4, 7]
# player = [0, 8]      # 15
# opponent = [2, 4]
# player = [0, 2]      # 16
# opponent = [1, 8]
# player = [0, 8]      # 17
# opponent = [4, 6]
# player = [0, 4]      # 20
# opponent = [5, 8]
# player = [0, 4]      # 21
# opponent = [7, 8]
# player = [0, 2]      # 22
# opponent = [6, 8]
# player = [4, 8]      # 23
# opponent = [2, 3]
# player = [0, 4]      # 24
# opponent = [2, 3]

#   20      21
#  X - -   X - -
#  - X O   - X -  # false positives earlier
#  - - O   - O O

# # taken = player + opponent
# p_cor = player & corners  # player corners
# o_cor = opponent & corners  # opponent corners
# # adj_cor_edg = false
# o_adj = false  # opponent marks adjacency
# # cor_edg.each { |set| adj_cor_edg = true if (taken & set).size > 1 }  # check if mutl
# sides.each { |side| o_adj = true if (side & opponent).size > 1 }  # check if opponent marks adjacent

# if (player & center).size == 1 && o_cor[0] == sel_op_cor(p_cor) && o_adj == false #&& adj_cor_edg == true
#   puts "pattern matched"
# else
#   puts "nope"
# end


# testing above....

#---------------------------------------------

# Pattern matching done, now need position selection logic

# X O -   X - -
# - X -   O X -  18 (b1) & 19 (t3)
# - - O   - - O

taken = player + opponent  # all occupied board positions
p_cor = player & corners  # player corners
o_cor = opponent & corners  # opponent corners
o_adj = false  # opponent marks adjacency
sides.each { |side| o_adj = true if (side & opponent).size > 1 }  # check if opponent marks adjacent
if (player & center).size == 1 && o_cor[0] == sel_op_cor(p_cor) && o_adj == false
  side_index = 0  # array index for sides (clockwise: top = 0, right = 1, bottom = 2, right = 3)
  # get @sides array index of side with adjacent player and opponent marks
  sides.each_with_index { |side, s_index| side_index = s_index if (taken & side).size > 1 }
  refcor = sides[side_index] - (taken & sides[side_index])  # open corner on side with adj marks
  position = sel_op_cor(refcor)  # take corner that is opposite the reference corner
end

p position



* Just realized this is unnecessary logic for perfect X player - would never be in this position...  >_<
   * Actually, perfect X lost without it, so adding back in

#-------------------------------------

# testing below...

# p o_adj

# if (player & center).size == 1
#   puts "yes, X in middle"  # 3
# end

# if o_corner[0] == sel_op_cor(p_corner)
#   puts "yes, player & opponent corners are opposing"  # 2
# end

# adj_cor_edg = false

# cor_edg.each do |set|
#   adj_cor_edg = true if (taken & set).size > 1
# end

# p taken
# p adj_cor_edg

# set_1 = [3, 0, 1]
# set_2 = [1, 2, 5]
# set_3 = [5, 8, 7]
# set_4 = [7, 6, 3]

# p taken & set_1
# p taken & set_2
# p taken & set_3
# p taken & set_4


# # TO-DO - refactor this method, very ugly... and rename it, too
# # Method to return corner opposite to O when corner and non-adjacent edge, and final position handling
# def edge_logic(player, opponent)
#   all = @corners + @edges + @center  # all board positions
#   taken = player + opponent  # all occupied board positions
#   if taken.size < 7  # if called in a round lower than 8
#     side_index = 0  # array index for sides (clockwise: top = 0, right = 1, bottom = 2, right = 3)
#     # get array index of the side with adjacent player and opponent marks
#     @sides.each_with_index { |side, s_index| side_index = s_index if (taken & side).size > 1 }
#     # determine empty corner in side with adjacent player and opponent marks
#     refcor = @sides[side_index] - (taken & @sides[side_index])
#     position = sel_op_cor(refcor)  # take corner that is opposite the reference corner
#   else  # otherwise take one of the (or the very) last position
#     position = (all - taken).sample  # take a random position
#   end
# end
