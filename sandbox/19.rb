wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
@corners = [0, 2, 6, 8]
@edges = [1, 3, 5, 7]
@center = [4]

player = [0]
opponent = [8]

taken = player + opponent

# X - -
# - - -
# - - O

def get_matchups(wins, player, opponent)
  matchups = []  # [[0, 1, 2], [0, 3, 6]]
  wins.each do |win|
    if (player & win).size > 0 && (opponent & win).size == 0
      matchups.push(win)
    end
  end
  return matchups
end

def get_corner_fork(wins, player, opponent)
  matchups = get_matchups(wins, player, opponent)
  moves_corner = []
  matchups.each do |matchup|
    open_corner = (matchup - player) & @corners
    if open_corner.size > 0  # preference corners
      moves_corner += open_corner
    end
  end
  return moves_corner
end

def get_edge_fork(wins, player, opponent)
  matchups = get_matchups(wins, player, opponent)
  moves_edge = []
  matchups.each do |matchup|
    open_edge = (matchup - player) & @edges
    if open_edge.size > 0  # preference edge
      moves_edge += open_edge
    end
  end
  return moves_edge
end

def get_center_fork(wins, player, opponent)
  matchups = get_matchups(wins, player, opponent)
  moves_center = []
  matchups.each do |matchup|
    open_center = (matchup - player) & @center
    if open_center.size > 0  # preference center
      moves_center += open_center
    end
  end
  return moves_center
end

def get_fork(wins, player, opponent)
  moves = []
  corner_fork = get_corner_fork(wins, player, opponent)
  edge_fork = get_edge_fork(wins, player, opponent)
  center_fork = get_center_fork(wins, player, opponent)
  if corner_fork.size > 0
    moves += corner_fork
  elsif edge_fork.size > 0
    moves += edge_fork
  elsif center_fork.size > 0
    moves += center_fork
  end
  return moves
end

moves = get_fork(wins, player, opponent)
p moves