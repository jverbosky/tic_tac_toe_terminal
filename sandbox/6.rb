# O round 6 working:

# X X -
# - O -  * taking t3
# - O X

# - - X
# O O X  * taking b3
# X - -

# ---------------------------
# O round 6 not working:

# X O -
# - O -  * taking t3
# - X X

# - - X
# X O O  * taking b3
# X - -

# ---------------------------

Went to output player & opponent positions and realized issue
 - was calling move_o() with player and opponent arrays swapped  ^_^;