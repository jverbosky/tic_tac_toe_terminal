require_relative "board.rb"

# class for computer player that randomly places mark
class PlayerHuman

  def get_move(game_board, round, mark, wins, x_pos, o_pos)
    print "Please enter the desired location: "
    location = gets.chomp
  end

end

# Sandbox testing
# board = Board.new
# p1 = PlayerHuman.new
# round = board.get_round(board.x_count, board.o_count)
# mark = board.get_mark(board.x_count, board.o_count)
# wins = board.wins
# x_pos = board.get_x
# o_pos = board.get_o
# move = p1.get_move(board.game_board, round, mark, wins, x_pos, o_pos)
# p move