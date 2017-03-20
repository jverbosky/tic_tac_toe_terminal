wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
@corners = [0, 2, 6, 8]
@edges = [1, 3, 5, 7]
@center = [4]

# player = [3, 4]  # 2/8
# opponent = [1, 5, 6]
# player = [1, 5, 6]  # 0/7/8
# opponent = [2, 3, 4]
# player = [1, 5]
# opponent = [4, 7]  # 6
# player = [4, 7]
# opponent = [1, 5, 6]  # 0/2
# player = [2, 4]
# opponent = [1, 5, 6]
player = [4]
opponent = [3, 7]

# Method to return array of potential wins for forking player
def get_potential_wins(wins, forker, forkee)
  potential_wins = []
  wins.each do |win|
    potential_wins.push(win) if (forker & win).size > 0 && (forkee & win).size == 0
  end
  return potential_wins  # [[0, 1, 2], [6, 7, 8], [2, 5, 8]]
end

# Method to return hash of positions and counts to help identify forks
def count_positions(wins, forker, forkee)
  potential_wins = get_potential_wins(wins, forker, forkee)
  position_counts = {}
  potential_wins.each do |potential_win|
    potential_win.each do |position|
      position_counts[position] = 0 if position_counts[position] == nil
      position_counts[position] += 1
    end
  end
  return position_counts  # {0=>1, 1=>1, 2=>2, 6=>1, 7=>1, 8=>2, 5=>1}
end

# Method to return array of positions that will result in a fork
def find_fork(wins, forker, forkee)
  position_counts = count_positions(wins, forker, forkee)
  forking_moves = []
  position_counts.each do |position, count|
    forking_moves.push(position) if count > 1
  end
  return forking_moves  # [2, 8]
end

def check_forks_o(wins, player, opponent)
  block_fork = find_fork(wins, opponent, player)
  get_fork = find_fork(wins, player, opponent)
  if block_fork.size > 0
    move = block_fork.sample
  elsif get_fork.size > 0
    move = get_fork.sample
  else
    move = sel_rand(player, opponent)
  end
  return move
end

# Method to return move that will block a fork, create a fork, or fallback on random
def check_forks_x(wins, player, opponent)
  block_fork = find_fork(wins, opponent, player)
  get_fork = find_fork(wins, player, opponent)
  if get_fork.size > 0
    move = get_fork.sample
  elsif block_fork.size > 0
    move = block_fork.sample
  else
    move = sel_rand(player, opponent)
  end
  return move
end

# Method to return a random open position, called when no win/block moves in rounds 8 and 9
def sel_rand(player, opponent)
  all = @corners + @edges + @center  # all board positions
  taken = player + opponent  # all occupied board positions
  position = (all - taken).sample  # take a random open position
end

# p get_potential_wins(wins, opponent, player)  # [[6, 7, 8], [0, 4, 8], [2, 4, 6]]
# p get_potential_wins(wins, player, opponent)  # [[0, 1, 2], [2, 5, 8]]

# p count_positions(wins, opponent, player)  # {6=>2, 7=>1, 8=>2, 0=>1, 4=>2, 2=>1}
# p count_positions(wins, player, opponent) # {0=>1, 1=>1, 2=>2, 5=>1, 8=>1}

# p find_fork(wins, opponent, player)  # [6, 8, 4]
# p find_fork(wins, player, opponent)  # [2]

p check_forks_o(wins, player, opponent)  # 8
# p check_forks(wins, opponent, player)  # 2