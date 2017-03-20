wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
@corners = [0, 2, 6, 8]
@edges = [1, 3, 5, 7]
@center = [4]

player = [3, 4]
opponent = [1, 5, 6]

  def get_potential_wins(wins, forker, forkee)
    potential_wins = []
    wins.each do |win|
      if (forker & win).size > 0 && (forkee & win).size == 0
        potential_wins.push(win)
      end
    end
    # p "get_potential_wins: #{potential_wins}"
    return potential_wins
  end

  def block_fork(wins, opponent, player)
    potential_wins = get_potential_wins(wins, opponent, player)
    position_counts = {}
    forking_moves = []
    potential_wins.each do |potential_win|
      # puts "current potential win: #{potential_win}"
      potential_win.each do |position|
        # puts "current position: #{position}"
        position_counts[position] = 0 if position_counts[position] == nil
        position_counts[position] += 1
      end
    end
    # puts "positions count hash: #{counts}"
    counts.each do |position, count|
      forking_moves.push(position) if count > 1
    end
    # puts "forking_moves: #{forking_moves}"
    forking_moves.size > 0 ? forking_moves.sample : get_fork(wins, player, opponent)
  end

  def get_fork(wins, player, opponent)
    moves = []
    corner_fork = get_corner_fork(wins, player, opponent)
    edge_fork = get_edge_fork(wins, player, opponent)
    center_fork = get_center_fork(wins, player, opponent)
    if corner_fork.size > 0  # preference corners
      moves += corner_fork
    elsif edge_fork.size > 0  # then edges
      moves += edge_fork
    elsif center_fork.size > 0  # then center
      moves += center_fork
    end
    moves.size > 0 ? moves.sample : sel_rand(player, opponent)
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
    p "get_corner_fork: #{moves_corner}"
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
    p "get_edge_fork: #{moves_edge}"
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
    p "get_center_fork: #{moves_center}"
    return moves_center
  end

  # Method to return a random open position, called when no win/block moves in rounds 8 and 9
  def sel_rand(player, opponent)
    all = @corners + @edges + @center  # all board positions
    taken = player + opponent  # all occupied board positions
    position = (all - taken).sample  # take a random open position
  end


p block_fork(wins, opponent, player)
