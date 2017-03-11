require "minitest/autorun"
require_relative "../player_rand.rb"

class TestPlayerRandom < Minitest::Test

  def test_1_verify_random_move
    board = Board.new
    p1 = PlayerRandom.new
    round = board.get_round(board.x_count, board.o_count)
    mark = board.get_mark(board.x_count, board.o_count)
    wins = board.wins
    x_pos = board.get_x
    o_pos = board.get_o
    move = p1.get_move(board.game_board, round, mark, wins, x_pos, o_pos)
    result = p1.moves.include?(move)
    assert_equal(true, result)
  end

end