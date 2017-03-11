require "minitest/autorun"
require_relative "../position.rb"

class TestPosition < Minitest::Test

  def test_1_get_array_index_for_t1
    position = Position.new
    move = "t1"
    result = position.get_index(move)
    assert_equal(0, result)
  end

  def test_2_get_array_index_for_t2
    position = Position.new
    move = "t2"
    result = position.get_index(move)
    assert_equal(1, result)
  end

  def test_3_get_array_index_for_t3
    position = Position.new
    move = "t3"
    result = position.get_index(move)
    assert_equal(2, result)
  end

  def test_4_get_array_index_for_m1
    position = Position.new
    move = "m1"
    result = position.get_index(move)
    assert_equal(3, result)
  end

  def test_5_get_array_index_for_m2
    position = Position.new
    move = "m2"
    result = position.get_index(move)
    assert_equal(4, result)
  end

  def test_6_get_array_index_for_m3
    position = Position.new
    move = "m3"
    result = position.get_index(move)
    assert_equal(5, result)
  end

  def test_7_get_array_index_for_b1
    position = Position.new
    move = "b1"
    result = position.get_index(move)
    assert_equal(6, result)
  end

  def test_8_get_array_index_for_b2
    position = Position.new
    move = "b2"
    result = position.get_index(move)
    assert_equal(7, result)
  end

  def test_9_get_array_index_for_b3
    position = Position.new
    move = "b3"
    result = position.get_index(move)
    assert_equal(8, result)
  end

end