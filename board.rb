# class to handle game board items
class Board

  # Method to access the variables in the class - attr_ is shorthand syntax for creating getter/setter methods
  # attr_reader = read-only, attr_writer = write-only, attr_accessor = read/write
  attr_reader :wins, :win
  attr_accessor :game_board # needs to be read/write in order to change the value of board in tests

  def initialize
    # use instance variable if not resetting the value anywhere else
    @game_board = ["", "", "", "", "", "", "", "", ""]
    @wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    @win = []  # populated with winning positions by game_won?
  end

  def position_open?(position)
    @game_board[position] == ""
  end

  def set_position(position, mark)
    @game_board[position] = mark if position_open?(position)
  end

  def board_full?
    @game_board.count("") == 0
  end

  def get_x
    @game_board.each_index.select { |position| @game_board[position] == "X" }
  end

  def get_o
    @game_board.each_index.select { |position| @game_board[position] == "O" }
  end

  def x_count
    @game_board.count("X")
  end

  def o_count
     @game_board.count("O")
  end

  def get_mark(x_count, o_count)
    x_count > o_count ? "O" : "X"
  end

  def get_round(x_count, o_count)
    x_count + o_count + 1
  end

  def game_won?(positions)
    won = false
    @wins.each { |win| (won = true; @win = win) if positions & win == win }
    won
  end

  def x_won?(get_x)
    positions = get_x
    game_won?(positions)
  end

  def o_won?(get_o)
    positions = get_o
    game_won?(positions)
  end

end