# Adding logic for round 5 (X at corner and edge, O blocking and opposite corner)

# O - -   O X -
# X X O   - X -  > 73 r5 - X (t2), 75 r5 - X (m1)
# - - -   - O -

# Currently using else block in move_r5()
# Other patterns that require else block in move_r5():

#  18       19      20      21

# X O -   X - -   X - -   X - -
# - X -   O X -   - X O   - X -
# - - O   - - O   - - O   - O O

#  22       23      24

# X - X   - - O   X - O
# - - -   O X -   O X -
# O - O   - - X   - - -

# None have X at center and edge, so filter on that

#----------------------------------------------------
edges = [1, 3, 5, 7]
center = [4]

player = [3, 4]
opponent = [0, 5]


if (player & center).size == 1 && (player & edges).size == 1

  ### Stopped - saw the forest for the trees - don't need to code logic for non-perfect X....  ^_^;