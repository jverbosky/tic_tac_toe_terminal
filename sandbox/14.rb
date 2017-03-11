# Round 7 Research

# 85 - 86

# X should take either open edge for a chance to win

# O - X   O X O
# X X O   - X -
# O - -   - O X

# Pattern:
# 1) Adjacent opponent corners
# 2) Opponent edge on opposite side

# sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]
# corners = [0, 2, 6, 8]
# adjcor = [[8, 6], [2, 8], [6, 0], [0, 2]]
# edges = [1, 3, 5, 7]

# player = [2, 3, 4]
# opponent = [0, 5, 6]
# # player = [1, 4, 8]
# # opponent = [0, 2, 7]

# taken = player + opponent
# taken_edges = taken & edges
# c_index = 11 # adjcor index that contains opponent corners
# e_index = 17 # edges index that contains opponent corners

# # Collect indexes of opponent's adjacent corner pair and opposite edge
# edges.each_with_index { |edge, edge_index| e_index = edge_index if opponent.include? edge }
# adjcor.each_with_index { |pair, a_index| c_index = a_index if (opponent & pair).size == 2 }
# if c_index == e_index  # if index of adjacent corners and corner match, they oppose
#   position = (edges - taken_edges).sample  # so take random open edge
# end

# p position

#------------------------------------------

@opcor_1 = [0, 8]  # opposite corners - set 1
@opcor_2 = [2, 6]  # opposite corners - set 2

# Method to return the corner opposite the current corner
def op_corner(corner)
  if (@opcor_1 - corner).size == 1  # if @opcor_1 and corner differ by 1
    position = (@opcor_1 - corner)[0]  # then the opposite corner is the other element in @opcor_1
  else
    position = (@opcor_2 - corner)[0]  # otherwise the opposite corner is the other element in @opcor_2
  end
end

# 87 - 88 > 103 - 104

# X should take corner that not opposite from O corner

# O X -
# X X O  # both boards same in r7
# - O -

corners = [0, 2, 6, 8]
adjedg = [[5, 7], [3, 7], [1, 5], [1, 3]]

player = [1, 3, 4]
opponent = [0, 5, 7]

taken = player + opponent  # all occupied board positions
taken_corner = opponent & corners  # corners taken by opponent
opposite_corner = [op_corner(taken_corner)]  # corner across from opponent corner
c_index = 11  # index of @corners (placeholder value to avoid false positives)
adj_e_index = 17  # index of @adjedg pair (placeholder value to avoid false positives)

corners.each_with_index { |corner, cor_index| c_index = cor_index if opponent.include? corner }
adjedg.each_with_index { |e_pair, adj_index| adj_e_index = adj_index if (opponent & e_pair).size == 2 }

if c_index == adj_e_index  # if index of adjacent edges and corner match, they oppose
  puts "yes"
  position = (corners - (taken_corner + opposite_corner)).sample  # so take random non-opposite open corner
end

p opposite_corner
p position

#------------------------------------------

# Added move_r7 and now some "unrelated" tests failing - errors referencing lines that are not in player_perf.rb

# 27 - 359
# 32 - 424
# 33 - 437

# Need to research

