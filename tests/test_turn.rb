# Merged tests into test_board.rb

# require "minitest/autorun"
# require_relative "turn.rb"

class TestTurn < Minitest::Test

  def test_1_get_player_first_move
    board = Board.new
    turn = Turn.new
    result = turn.get_mark(board.x_count, board.o_count)
    assert_equal("X", result)
  end

  def test_2_get_player_second_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "", "", ""]
    turn = Turn.new
    result = turn.get_mark(board.x_count, board.o_count)
    assert_equal("O", result)
  end

  def test_3_get_player_third_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "O", "", ""]
    turn = Turn.new
    result = turn.get_mark(board.x_count, board.o_count)
    assert_equal("X", result)
  end

  def test_4_get_player_seventh_move
    board = Board.new
    board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]
    turn = Turn.new
    result = turn.get_mark(board.x_count, board.o_count)
    assert_equal("X", result)
  end

  def test_5_get_player_eighth_move
    board = Board.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]
    turn = Turn.new
    result = turn.get_mark(board.x_count, board.o_count)
    assert_equal("O", result)
  end

  def test_6_get_round_first_move
    board = Board.new
    turn = Turn.new
    result = turn.get_round(board.x_count, board.o_count)
    assert_equal(1, result)
  end

  def test_7_get_round_second_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "", "", ""]
    turn = Turn.new
    result = turn.get_round(board.x_count, board.o_count)
    assert_equal(2, result)
  end

  def test_8_get_round_third_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "O", "", ""]
    turn = Turn.new
    result = turn.get_round(board.x_count, board.o_count)
    assert_equal(3, result)
  end

  def test_9_get_round_seventh_move
    board = Board.new
    board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]
    turn = Turn.new
    result = turn.get_round(board.x_count, board.o_count)
    assert_equal(7, result)
  end

  def test_10_get_round_eighth_move
    board = Board.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]
    turn = Turn.new
    result = turn.get_round(board.x_count, board.o_count)
    assert_equal(8, result)
  end

end