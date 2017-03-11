# X_took_adjacent_corners_and_opposite_edge_O_takes_open_edge_v1

# board.game_board = ["X", "O", "X", "", "O", "", "", "X", ""]  # m1/m3  # 79
# board.game_board = ["", "", "X", "X", "O", "O", "", "", "X"]  # t2/b2  # 80

# X O X   - - X
# - O -   X O O  # 79 & 80
# - X -   - - X

# X O -   O X -
# - O -   - O -  # 52 & 91 were false positives, changed c_side/e_side to 7 to avoid
# - X X   - X X

# sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]
# corners = [0, 2, 6, 8]
# edges = [1, 3, 5, 7]

# opponent = [0, 2, 7]  # 79
# player = [1, 4]
# opponent = [2, 3, 8]  # 80
# player = [4, 5]
# opponent = [0, 7, 8]  # 52
# player = [1, 4]
# opponent = [1, 7, 8]  # 91
# player = [0, 4]

# Check:
# 1) Find index of side with two X
# 2) Check opposite side edge

# taken_corners = opponent & corners  # [0, 2]
# taken_edges = opponent & edges  # [7]
# c_side = 7  # side with corners  # 0
# e_side = 7  # side with edge

# sides.each_with_index { |side, s_index| c_side = s_index if (side & taken_corners).size == 2 }
# sides.each_with_index { |side, s_index| e_side = s_index if (side & taken_edges).size == 1 }

# if (c_side - e_side).abs == 2
#   taken = player + opponent  # [1, 4, 0, 2, 7]
#   taken_edges = taken & edges  # [1, 7]
#   position = (edges - taken_edges).sample  # 3/5
# end

# p "Taken corners: #{taken_corners}"
# p "Taken edges: #{taken_edges}"
# p "c_side: #{c_side}"
# p "e_side: #{e_side}"
# p "Position: #{position}"
#---------------------------------------------------------

# X_took_adjacent_edges_and_opposite_corner_O_takes_open_corner

# game_board = ["", "X", "O", "", "O", "X", "X", "", ""]  # t1/b3  # 93
# game_board = ["X", "", "", "", "O", "X", "", "X", "O"]  # t3/b1  # 94

# - X O   X - -
# - O X   - O X  # 93 & 94
# X - -   - X O

sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]
edges = [1, 3, 5, 7]
corners = [0, 2, 6, 8]
adjedg = [[5, 7], [3, 7], [1, 5], [1, 3]]  # adjacent edges (order vital for opposite corner comparison)

# player = [2, 4]
# opponent = [1, 5, 6]
player = [4, 8]
opponent = [0, 5, 7]

taken = player + opponent  # all occupied board positions
e_index = 11
c_index = 17
adjedg.each_with_index { |edges, adj_index| e_index = adj_index if (opponent & edges).size == 2 }
corners.each_with_index { |corner, cor_index| c_index = cor_index if opponent.include? corner }
if e_index == c_index  # if index of adjacent edges and corner match, they oppose
  position = (corners - (taken & corners)).sample
end

p position