# Revised 67 -68 logic to grab edge opposite corner X

# X - -
# - O -  > should take m3 (5)
# - X -

# round_4_X_took_corner_and_non_adjacent_edge_O_takes_edge_opposite_corner_X_v1

=begin
board = ["X", "", "", "", "O", "", "", "X", ""]  # need to take m3
sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]
adjedg = [[5, 7], [3, 7], [1, 5], [1, 3]]
edges = [1, 3, 5, 7]
corners = [0, 2, 6, 8]

opponent = [0, 7]
player = [4]

corner = corners & opponent
p corner  # [0]

edge = edges & opponent
p edge  # [7]

target = []
# collect positions of edges from sides without opponent corner
sides.each { |side| target += (side & edges) if (side & corner).size == 0 }
p target  # [5, 7]

position = target - edge  # get position of open edge
p position # [5]

=end

#---------------------------------------------------------------------

# Revised 77 -78 logic to grab corner between adjacent X edges

# - X -   - - -
# - O X   - O X
# - - -   - X -

sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]
adjedg = [[1, 5], [5, 7], [7, 3], [3, 1]]
corners = [0, 2, 6, 8]

# opponent = [1, 5]
opponent = [5, 7]

# 1) Find sides that contain X
# 2) Find the corner that is in both sides

target = []
sides.each { |side| target += side if (opponent & side).size > 0 }
p target
position = target.detect{ |value| target.count(value) > 1 }
p position

# Old version
  # # Method to return random corner except the one opposite to adjacent edges
  # def adj_edge_logic(player, opponent)
  #   side_index = 0  # use to determine corner to knock out
  #   # determine the adjedg array index of the pair of adjacent edges
  #   @adjedg.each_with_index { |pair, adj_index| side_index = adj_index if (opponent & pair).size == 2 }
  #   op_corner = [@corners[side_index]]  # use the index to identify the opposite corner
  #   position = (@corners - op_corner).sample  # randomly return any corner except opposite one
  # end