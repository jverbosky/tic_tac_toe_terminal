@wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
@corners = [0, 2, 6, 8]
@edges = [1, 3, 5, 7]
@center = [4]

@matchups = []
@fork_corner = []  # fork corner moves
@fork_edge = []  # fork edge moves
@fork_center = []  # fork center move

@player = [0]
@opponent = [8]

# X - -
# - - -
# - - O

def get_matchups
  @matchups = []  # [[0, 1, 2], [0, 3, 6]]
  @wins.each do |win|
    @matchups.push(win) if (@player & win).size > 0 && (@opponent & win).size == 0
  end
end

def get_corner_fork
  @fork_corner = []
  @matchups.each do |matchup|
    open_corner = (matchup - @player) & @corners
    @fork_corner += open_corner if open_corner.size > 0
  end
end

def get_edge_fork
  @fork_edge = []
  @matchups.each do |matchup|
    open_edge = (matchup - @player) & @edges
    @fork_edge += open_edge if open_edge.size > 0
  end
end

def get_center_fork
  @fork_center = []
  @matchups.each do |matchup|
    open_center = (matchup - @player) & @center
    @fork_center += open_center if open_center.size > 0  # preference center
  end
end

def get_fork
  moves = []
  get_matchups
  get_corner_fork
  get_edge_fork
  get_center_fork
  if @fork_corner.size > 0  # preference corners
    moves += @fork_corner
  elsif @fork_edge.size > 0  # then edges
    moves += @fork_edge
  elsif @fork_center.size > 0  # then center
    moves += @fork_center
  end
  return moves
end

p get_fork
