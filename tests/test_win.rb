# Merged tests into test_board.rb

# require "minitest/autorun"
# require_relative "win.rb"

class TestWin < Minitest::Test

  def test_1_game_won_false
    board = Board.new
    win = Win.new
    result = win.game_won?(board.get_x)
    assert_equal(false, result)
  end

  def test_2_game_won_true_x
    board = Board.new
    win = Win.new
    board.game_board = ["O", "O", "X", "O", "", "X", "X", "O", "X"]
    result = win.game_won?(board.get_x)
    assert_equal(true, result)
  end

  def test_3_game_won_true_o
    board = Board.new
    win = Win.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "O", "O"]
    result = win.game_won?(board.get_o)
    assert_equal(true, result)
  end

  def test_4_x_won_false
    board = Board.new
    win = Win.new
    board.game_board = ["", "X", "", "O", "X", "", "O", "", "X"]
    result = win.x_won?(board.get_x)
    assert_equal(false, result)
  end

  def test_5_x_won_true
    board = Board.new
    win = Win.new
    board.game_board = ["O", "O", "X", "O", "", "X", "X", "O", "X"]
    result = win.x_won?(board.get_x)
    assert_equal(true, result)
  end

  def test_6_o_won_false
    board = Board.new
    win = Win.new
    board.game_board = ["", "X", "", "O", "X", "", "O", "", "X"]
    result = win.o_won?(board.get_o)
    assert_equal(false, result)
  end

  def test_7_o_won_true
    board = Board.new
    win = Win.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "O", "O"]
    result = win.o_won?(board.get_o)
    assert_equal(true, result)
  end

end