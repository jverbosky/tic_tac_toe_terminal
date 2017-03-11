# board = *(0..8)
# p board

position = []

player = [0, 7]
opponent = [5, 6]

p player + opponent
# p board - (player + opponent)

p (Array(0..8) - (player + opponent)).sample
