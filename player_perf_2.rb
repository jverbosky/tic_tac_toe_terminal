require_relative "board.rb"

# class for computer player that plays perfectly to a win or a tie
class PlayerPerfect2

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]  # "human friendly" board positions
    @sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]  # sides (top, right, bottom, left)
    @corners = [0, 2, 6, 8]  # corner positions
    @opcor_1 = [0, 8]  # opposite corners - set 1
    @opcor_2 = [2, 6]  # opposite corners - set 2
    @adjcor = [[8, 6], [2, 8], [6, 0], [0, 2]]  # adjacent corners (order vital for opposite edge comparison)
    @edges = [1, 3, 5, 7]  # edge positions
    @opedg_1 = [1, 7]  # opposite edges - set 1
    @opedg_2 = [3, 5]  # opposite edges - set 2
    @adjedg = [[5, 7], [3, 7], [1, 5], [1, 3]]  # adjacent edges (order vital for opposite corner comparison)
    @center = [4]  # center position
  end

  # Method to retrieve optimal position and convert it to a "human friendly" board position
  def get_move(game_board, round, mark, wins, x_pos, o_pos)
    # Use current mark (X/O) to determine  current player, then call appropriate method to get position
    mark == "X" ? position = move_x(wins, x_pos, o_pos, round) : position = move_o(wins, o_pos, x_pos, round)
    # Translate the position's array index to a "human friendly" board position and return it
    move = @moves[position]
  end

  # Method to handle X logic for different rounds
  def move_x(wins, player, opponent, round)
    if round == 1  # in round 1
      position = @corners.sample  # take a corner, any corner
    elsif round == 3  # in round 3
      position = move_r3(wins, player, opponent)  # determine ideal position based on O's position
    else  # in remaining rounds
      position = win_check(wins, player, opponent)  # use win/block logic for rounds 5+
    end
  end

  # Method to handle O logic for different rounds
  def move_o(wins, player, opponent, round)
    if round == 2  # in round 2
      # check if X took center and if so take a corner, otherwise take center
      (opponent & @center).size == 1 ? position = @corners.sample : position = 4
    elsif round == 4  # in round 4 determine ideal position based on X and O's positions
      position = move_r4(wins, player, opponent)
    else  # use win/block logic for rounds 6+
      position = win_check(wins, player, opponent)
    end
  end

  # Method to handle logic based on move O made in round 2
  def move_r3(wins, player, opponent)
    taken = player + opponent  # all occupied board positions
    if (opponent & @edges).size > 0  # if O took an edge
      position = 4  # take center
    elsif (opponent & @center).size > 0  # if O took center
      position = sel_op_cor(player)  # take the opposite corner
    else  # if O took a corner, take an open corner
      position = (@corners - taken).sample
    end
  end

  # Method to handle logic based on player positions in round 4
  def move_r4(wins, player, opponent)
    taken = player + opponent  # all occupied board positions
    if (opponent & @opcor_1).size == 2 || (opponent & @opcor_2).size == 2
      position = @edges.sample  # if X took opposite corners - take an edge, any edge
    elsif (opponent & @opedg_1).size == 2 || (opponent & @opedg_2).size == 2
      position = @corners.sample  # if X took opposite edges - take a corner, any corner
    elsif (taken & (@opcor_1 + @center)).size == 3 || (taken & (@opcor_2 + @center)).size == 3
      position = sel_avail_cor(player, opponent)  # if X+O have opcor pair and center, take random open corner
    elsif (opponent & @edges).size == 1 && (opponent & @corners).size == 1  # if X has one edge and one corner
      position = sel_adj_edg(wins, player, opponent)  # take the edge opposite opponent corner or block
    else
      position = win_check(wins, player, opponent)  # otherwise use win/block logic
    end
  end

  # Method to return the corner opposite the current corner
  def sel_op_cor(corner)
    # if @opcor_1 and corner differ by 1 opposite corner is in @opcor_1, otherwise its in @opcor_2
    (@opcor_1 - corner).size == 1 ? position = (@opcor_1 - corner)[0] : position = (@opcor_2 - corner)[0]
  end

  # Method to return random open corner when player and opponent occupy one pair of opposing corners
  def sel_avail_cor(player, opponent)
    taken = player + opponent  # all occupied board positions
    # determine which corners are taken and take a random corner from the open opcor pair
    (taken & @opcor_1).size == 2 ? position = @opcor_2.sample : position = @opcor_1.sample
  end

  # Method to select open adjacent edge across from opponent corner
  def sel_adj_edg(wins, player, opponent)
    adjacent = false  # determine adjacency
    @sides.each { |side| adjacent = true if (opponent & side).size > 1 }  # check if edge and corner are adjacent
    if adjacent == false  # if edge and corner not adjacent, take open edge opposite opponent corner
      corner = (@corners & opponent)[0]  # opponent corner
      edge = @edges & opponent  # opponent edge
      op_adjedg = @adjedg[@corners.index(corner)]  # pair of adjacent edges opposite to corner
      position = (op_adjedg - edge)[0]  # take open edge in adjacent edges pair
    else
      position = block_check(wins, player, opponent)  # otherwise edge and corner are adjacent, so block at corner
    end
  end

  # Method to return position to win, call block_check() if no wins
  def win_check(wins, player, opponent)
    position = []  # placeholder for position that will give 3-in-a-row
    wins.each do |win|  # check each win pattern
      difference = win - player  # difference between current win array and player position array
      # if player 1 move from win, take position unless already opponent mark
      position.push(difference[0]) unless (opponent & difference).size == 1 if difference.size == 1
    end  # .sample in case of multiple wins, otherwise check for blocks
    position.size > 0 ? position.sample : block_check(wins, player, opponent)
  end

  # Method to return position to block, call sel_rand() if no blocks (rounds 8 and 9)
  def block_check(wins, player, opponent)
    position = []  # placeholder for position that will block the opponent
    wins.each do |win|  # check each win pattern
      difference = win - opponent  # difference between current win array and opponent position array
      # if opponent 1 move from win, block position unless already player mark
      position.push(difference[0]) unless (player & difference).size == 1 if difference.size == 1
    end  # .sample in case of multiple blocks, otherwise check for forks
    position.size > 0 ? position.sample : fork_check(wins, player, opponent)
  end

  # Method to return move to block fork, will create fork or fallback on random if none
  def fork_check(wins, player, opponent)
    block_fork = find_fork(wins, opponent, player)
    get_fork = find_fork(wins, player, opponent)
    if get_fork.size > 0
      move = get_fork.sample
    elsif block_fork.size > 0
      move = block_fork.sample
    else
      move = sel_rand(player, opponent)
    end
  end

  # Method to return array of positions that will result in a fork
  def find_fork(wins, forker, forkee)
    position_counts = count_positions(wins, forker, forkee)
    forking_moves = []
    position_counts.each do |position, count|
      forking_moves.push(position) if count > 1
    end
    (forking_moves & forker).empty? ? forking_moves : []
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

  # Method to return array of potential wins for forking player
  def get_potential_wins(wins, forker, forkee)
    potential_wins = []
    wins.each do |win|
      potential_wins.push(win) if (forker & win).size > 0 && (forkee & win).size == 0
    end
    return potential_wins
  end

  # Method to return a random open position, called when no win/block moves in rounds 8 and 9
  def sel_rand(player, opponent)
    all = @corners + @edges + @center  # all board positions
    taken = player + opponent  # all occupied board positions
    position = (all - taken).sample  # take a random open position
  end

end

#-----------------------------------------------------------------------------
# Sandbox testing
# - Same tests as in test_player_perf.rb, just here to make tracing easier
#-----------------------------------------------------------------------------
# board = Board.new
# p1 = PlayerPerfect2.new
#-----------------------------------------------------------------------------
# Round 1 - X
#-----------------------------------------------------------------------------
# board.game_board = ["", "", "", "", "", "", "", "", ""]  # X takes a random corner (t1/t3/b1/b3) 1
#-----------------------------------------------------------------------------
# Round 2 - O
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "", "", "", "", "", "", ""]  # O takes center (m2) 2
#-----------------------------------------------------------------------------
# board.game_board = ["", "", "", "", "X", "", "", "", ""]  # X took center, O takes a random corner (t1/t3/b1/b3) 3
# board.game_board = ["", "X", "", "", "", "", "", "", ""]  # X took edge, O takes center v1 (m2) 4
# board.game_board = ["", "", "", "X", "", "", "", "", ""]  # X took edge, O takes center v2 (m2) 5
#-----------------------------------------------------------------------------
# Round 3 - X
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "", "", "O", "", "", "", ""]  # Perfect O - took center v1 (b3) 6
# board.game_board = ["", "", "X", "", "O", "", "", "", ""]  # Perfect O - took center v2 (b1) 7
# board.game_board = ["", "", "", "", "O", "", "X", "", ""]  # Perfect O - took center v3 (t3) 8
# board.game_board = ["", "", "", "", "O", "", "", "", "X"]  # Perfect O - took center v4 (t1) 9
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "", "", "", "", "", "O", ""]  # O took edge, X takes center (m2) 10
# board.game_board = ["X", "", "O", "", "", "", "", "", ""]  # O took corner, X takes op corner v1 (b3) 11
# board.game_board = ["O", "", "X", "", "", "", "", "", ""]  # O took corner, X takes op corner v2 (b1) 12
# board.game_board = ["X", "", "", "", "", "", "", "", "O"]  # O took op corner, X takes corner v1 (t3/b1) 13
# board.game_board = ["", "", "X", "", "", "", "O", "", ""]  # O took op corner, X takes corner v2 (t1/b3) 14
#-----------------------------------------------------------------------------
# Round 4 - O
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "", "", "O", "", "", "", "X"]  # Perfect X - took opposite corner v1 (t2/m1/m3/b2) 15
# board.game_board = ["", "", "X", "", "O", "", "X", "", ""]  # Perfect X - took opposite corner v2 (t2/m1/m3/b2) 16
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "X", "", "O", "", "", "", ""]  # X took corner and adjacent corner, O blocks at edge v1 (t2) 17
# board.game_board = ["", "", "X", "", "O", "", "", "", "X"]  # X took corner and adjacent corner, O blocks at edge v2 (m3) 18
# board.game_board = ["X", "X", "", "", "O", "", "", "", ""]  # X took corner and adjacent edge, O blocks at adjacent corner v1 (t3) 19
# board.game_board = ["", "", "X", "", "O", "X", "", "", ""]  # X took corner and adjacent edge, O blocks at adjacent corner v2 (b3) 20
# board.game_board = ["X", "", "", "", "O", "", "", "X", ""]  # X took corner and non-adjacent edge, O takes edge opposite corner v1 (m3) 21
# board.game_board = ["X", "", "", "", "O", "X", "", "", ""]  # X took corner and non-adjacent edge, O takes edge opposite corner v2 (b2) 22
# board.game_board = ["O", "", "X", "", "X", "", "", "", ""]  # X took center and corner, O blocks at opposite corner v1 (b1) 23
# board.game_board = ["", "", "O", "", "X", "", "", "", "X"]  # X took center and corner, O blocks at opposite corner v2 (t1) 24
# board.game_board = ["O", "", "", "", "X", "", "", "", "X"]  # X took center and corner opposite O, O takes corner v1 (t3/b1) 25
# board.game_board = ["", "", "X", "", "X", "", "O", "", ""]  # X took center and corner opposite O, O takes corner v2 (t1/b3) 26
# board.game_board = ["O", "", "", "X", "X", "", "", "", ""]  # X took center and edge, O blocks at opposite edge v1 (m3) 27
# board.game_board = ["", "X", "O", "", "X", "", "", "", ""]  # X took center and edge, O blocks at opposite edge v2 (b2) 28
# board.game_board = ["", "X", "", "", "O", "", "", "X", ""]  # X took edge and opposite edge, O takes corner v1 (t1/t3/b1/b3) 29
# board.game_board = ["", "", "", "X", "O", "X", "", "", ""]  # X took edge and opposite edge, O takes corner v2 (t1/t3/b1/b3) 30
# board.game_board = ["", "X", "", "", "O", "X", "", "", ""]  # X took edge and adjacent edge, O takes corner between X v1 (t3) 31
# board.game_board = ["", "", "", "", "O", "X", "", "X", ""]  # X took edge and adjacent edge, O takes corner between X v2 (b3) 32
#-----------------------------------------------------------------------------
# Round 5 - X
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "", "", "O", "", "", "", "X"]  # Perfect O - took edge v1, X blocks (b2) 33
# board.game_board = ["X", "", "", "O", "O", "", "", "", "X"]  # Perfect O - took edge v2, X blocks (m3) 34
# board.game_board = ["X", "", "", "", "O", "O", "", "", "X"]  # Perfect O - took edge v3, X blocks (m1) 35
# board.game_board = ["X", "", "", "", "O", "", "", "O", "X"]  # Perfect O - took edge v4, X blocks (t2) 36
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "O", "", "O", "", "", "", "X"]  # O took center after corner, X block & sets 2 wins (b1) 37
# board.game_board = ["X", "O", "X", "", "", "", "", "", "O"]  # O took edge after op corner, X sets 2 wins (b1) 38
# board.game_board = ["X", "", "", "", "O", "", "O", "", "X"]  # O took corner after center, X block & sets 2 wins (t3) 39
# board.game_board = ["X", "", "", "", "X", "O", "", "", "O"]  # O took opposite corner and adjacent edge v1, X block & sets 2 wins (t3) 40
# board.game_board = ["X", "", "", "", "X", "", "", "O", "O"]  # O took took opposite corner and adjacent edge v2, X block & sets 2 wins (b1) 41
# board.game_board = ["", "", "X", "", "", "O", "X", "", "O"]  # O took adjacent corner and adjacent edge, X wins (m2) 42
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "X", "", "", "", "O", "", "O"]  # added failsafe logic to move_x() round 5 (t2) 43
# board.game_board = ["", "", "O", "O", "X", "", "", "", "X"]  # merged edge_logic() into block_check() (t1) 44
# board.game_board = ["X", "", "O", "O", "X", "", "", "", ""]  # merged edge_logic() into block_check() (b3) 45
#-----------------------------------------------------------------------------
# Round 6 - O
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "", "", "O", "", "", "X", "X"]  # Perfect X - blocks at edge, O blocks at corner v1 (b1) 46
# board.game_board = ["X", "X", "", "", "O", "", "", "O", "X"]  # Perfect X - blocks at edge, O blocks at corner v2 (t3) 47
# board.game_board = ["", "", "X", "O", "O", "X", "X", "", ""]  # Perfect X - blocks at edge, O blocks at corner v3 (b3) 48
# board.game_board = ["", "", "X", "X", "O", "O", "X", "", ""]  # Perfect X - blocks at edge, O blocks at corner v4 (t1) 49
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "X", "", "O", "", "", "X", ""]  # X took adjacent corners and opposite edges, O takes open edge v1 (m1/m3) 50
# board.game_board = ["", "", "X", "X", "O", "O", "", "", "X"]  # X took adjacent corners and opposite edges, O takes open edge v2 (t2/b2) 51
# board.game_board = ["X", "X", "O", "", "O", "", "X", "", ""]  # X took corner, adjacent edge and adjacent corner, O blocks at edge v1 (m1) 52
# board.game_board = ["X", "", "X", "", "O", "X", "", "", "O"]  # X took corner, adjacent edge and adjacent corner, O blocks at edge v2 (t2) 53
# board.game_board = ["X", "", "", "X", "O", "O", "", "X", ""]  # X took adjacent edges and adjacent corner, O blocks at corner v1 (b1) 54
# board.game_board = ["X", "X", "", "", "O", "X", "", "O", ""]  # X took adjacent edges and adjacent corner, O blocks at corner v2 (t3) 55
# board.game_board = ["O", "", "X", "X", "X", "", "O", "", ""]  # X took corner, center and opposite edge, O blocks at edge v1 (m3) 56
# board.game_board = ["O", "X", "O", "", "X", "", "X", "", ""]  # X took corner, center and opposite edge, O blocks at edge v2 (b2) 57
# board.game_board = ["O", "X", "", "X", "X", "O", "", "", ""]  # X took corner and adjacent edges, O blocks at edge v1 (b2) 58
# board.game_board = ["O", "X", "", "X", "X", "", "", "O", ""]  # X took corner and adjacent edges, O blocks at edge v2 (m3) 59
# board.game_board = ["O", "", "", "X", "X", "O", "X", "", ""]  # X took edge, adjacent corner and center, O blocks at corner v1 (t3) 60
# board.game_board = ["O", "X", "X", "", "X", "", "", "O", ""]  # X took edge, adjacent corner and center, O blocks at corner v2 (b1) 61
# board.game_board = ["O", "X", "", "", "O", "", "", "X", "X"]  # X took corner, adjacent edge and opposite edge, O blocks at corner v1 (b1) 62
# board.game_board = ["X", "", "", "X", "O", "X", "", "", "O"]  # X took corner, adjacent edge and opposite edge, O blocks at corner v2 (b1) 63
# board.game_board = ["", "X", "O", "", "O", "X", "X", "", ""]  # X took adjacent edges and opposite corner, O takes open corner v1 (t1/b3) 64
# board.game_board = ["X", "", "", "", "O", "X", "", "X", "O"]  # X took adjacent edges and opposite corner, O takes open corner v2 (t3/b1) 65
#-----------------------------------------------------------------------------
# Round 7 - X
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "O", "O", "O", "", "X", "", "X"]  # O blocks at m1, X wins (b2) 66
# board.game_board = ["X", "", "O", "", "O", "", "X", "O", "X"]  # O blocks at b2, X wins (m1) 67
# board.game_board = ["X", "O", "X", "O", "", "", "X", "", "O"]  # O blocks at m1, X wins (m2) 68
# board.game_board = ["X", "O", "X", "", "O", "", "X", "", "O"]  # O blocks at m2, X wins (m1) 69
# board.game_board = ["X", "O", "X", "", "O", "", "O", "", "X"]  # O blocks at t2, X wins (m3) 70
# board.game_board = ["X", "", "X", "", "O", "O", "O", "", "X"]  # O blocks at m3, X wins (t2) 71
# board.game_board = ["X", "O", "", "", "O", "", "O", "X", "X"]  # X blocks O v1 (t3) 72
# board.game_board = ["X", "", "O", "O", "O", "X", "", "", "X"]  # X blocks O v2 (b1) 73
# board.game_board = ["", "", "X", "O", "O", "X", "X", "", "O"]  # X blocks O v3 (t1) 74
# board.game_board = ["O", "", "X", "X", "O", "O", "X", "", ""]  # X blocks O v4 (b3) 75
#-----------------------------------------------------------------------------
# - multiple selection tests
#-----------------------------------------------------------------------------
# board.game_board = ["O", "O", "", "X", "O", "X", "X", "", ""]   # multiple X blocks O (t3/b2/b3) 76
# board.game_board = ["X", "X", "", "O", "X", "O", "O", "", ""]   # multiple X wins (t3/b2/b3) 77
#-----------------------------------------------------------------------------
# Round 8 - O
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "X", "", "O", "", "O", "X", "X"]  # Perfect X - blocks at corner, O blocks at edge v1 (m3) 78
# board.game_board = ["X", "X", "O", "", "O", "", "X", "O", "X"]  # Perfect X - blocks at corner, O blocks at edge v2 (m1) 79
# board.game_board = ["X", "", "X", "O", "O", "X", "X", "", "O"]  # Perfect X - blocks at corner, O blocks at edge v3 (t2) 80
# board.game_board = ["O", "", "X", "X", "O", "O", "X", "", "X"]  # Perfect X - blocks at corner, O blocks at edge v4 (b2) 81
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "X", "O", "O", "X", "", "X", ""]  # X blocks at edge, O blocks at corner v1 (b3) 82
# board.game_board = ["", "X", "X", "X", "O", "O", "", "O", "X"]  # X blocks at edge, O blocks at corner v2 (t1) 83
# board.game_board = ["X", "X", "O", "O", "O", "X", "X", "", ""]  # X blocks at edge, O takes random position v1 (b2/b3) 84
# board.game_board = ["X", "O", "X", "", "O", "X", "", "X", "O"]  # X blocks at edge, O takes random position v2 (m1/b1) 85
# board.game_board = ["X", "", "X", "X", "O", "O", "O", "X", ""]  # X blocks at corner, O blocks at edge v1 (t2) 86
# board.game_board = ["X", "X", "O", "", "O", "X", "X", "O", ""]  # X blocks at corner, O blocks at edge v2 (m1) 87
# board.game_board = ["O", "", "X", "X", "X", "O", "O", "X", ""]  # X takes random open edge, O blocks at edge v1 (t2) 88
# board.game_board = ["O", "X", "O", "", "X", "X", "", "O", "X"]  # X takes random open edge, O blocks at edge v2 (m1) 89
# board.game_board = ["O", "X", "", "X", "X", "O", "X", "O", ""]  # X takes random non-opposite corner, O blocks at corner v1 (t3) 90
# board.game_board = ["O", "X", "X", "X", "X", "O", "", "O", ""]  # X takes random non-opposite corner, O blocks at corner v2 (b1) 91
# board.game_board = ["O", "", "O", "X", "X", "O", "X", "", "X"]  # X blocks at corner, O blocks at corner v1 (t2) 92
# board.game_board = ["O", "X", "X", "", "X", "", "O", "O", "X"]  # X blocks at corner, O blocks at corner v2 (m1) 93
# board.game_board = ["O", "X", "", "X", "O", "", "O", "X", "X"]  # X blocks at edge or corner, O wins via fork v1 (t3) 94
# board.game_board = ["X", "", "X", "X", "O", "X", "O", "", "O"]  # X blocks at edge or corner, O wins via fork v2 (b2) 95
# board.game_board = ["X", "X", "O", "", "O", "X", "X", "", "O"]  # X blocks at corner, O blocks at edge v1 (m1) 96
# board.game_board = ["X", "", "O", "", "O", "X", "X", "X", "O"]  # X blocks at corner, O blocks at edge v1 (m1) 97
#-----------------------------------------------------------------------------
# Round 9 - X
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "X", "", "O", "O", "O", "X", "X"]  # X ties v1 (m1)  98
# board.game_board = ["X", "", "O", "O", "O", "X", "X", "O", "X"]  # X ties v2 (t2)  99
# board.game_board = ["X", "O", "X", "O", "O", "X", "X", "", "O"]  # X ties v3 (b2)  100
# board.game_board = ["O", "", "X", "X", "O", "O", "X", "O", "X"]  # X ties v4 (t2)  101
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "X", "O", "O", "X", "", "X", "O"]  # X takes last open position, no win or block v1 (b1) 102
# board.game_board = ["O", "X", "X", "X", "O", "O", "", "O", "X"]  # X takes last open position, no win or block v2 (b1) 103
#-----------------------------------------------------------------------------
# Random tests
#-----------------------------------------------------------------------------
# board.game_board = ["O", "O", "", "", "", "", "X", "", "X"]  # (b2)
# board.game_board = ["", "X", "", "O", "O", "X", "X", "" ""]  # (b3/t3)
# board.game_board = ["", "X", "", "", "O", "", "", "", "X"]
#-----------------------------------------------------------------------------

# round = 4
# mark = "O"
# wins = board.wins
# x_pos = board.get_x
# o_pos = board.get_o
# # # puts "Player: #{x_pos}"  # X rounds (odd)
# # # puts "Opponent: #{o_pos}"  # X rounds (odd)
# # # puts "Player: #{o_pos}"  # O rounds (even)
# # # puts "Opponent: #{x_pos}"  # O rounds (even)
# puts p1.get_move(board.game_board, round, mark, wins, x_pos, o_pos)