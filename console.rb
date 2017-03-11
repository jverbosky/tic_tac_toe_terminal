# class to handle terminal output
require "io/console"

class Console

  attr_reader :p1_type, :p2_type, :key

  def initialize
    @p1_type = ""
    @p2_type = ""
    @key = ""
  end

  # Method to clear the screen regardless of OS
  def clear_screen
    RUBY_PLATFORM =~ /cygwin|mswin|mingw|bccwin|wince|emx/ ? system("cls") : system("clear")
  end

  # Method to print standalone border
  def border(n)
    puts "-" * n
  end

  # Method to allow console output to be more specified concisely
  def tab(n, *string)
    string.each_with_index { |e, i| i == 0 ? (puts " " * n + e) : (puts e) }
  end

  # Method that drives player selection messaging
  def select_players
    opening
    select_x
    select_o
    tab(2, "Please press Enter to begin!")
    gets
  end

  # Method to display the initial game screen with player selection information
  def opening
    clear_screen
    if $x_score + $o_score == 0
      border(31)
      tab(10, "Tic Tac Toe", "-" * 31, "\n")
    else
      header
      scorekeeping($x_score, $o_score)
    end
    tab(11, "  |   | X")
    tab(11, "-" * 9)
    tab(11, "O | O | X")
    tab(11, "-" * 9)
    tab(11, "X |   |", "\n", "-" * 31)
    tab(8, "Player Selection", "-" * 31)
    tab(11, "1 = human")
    tab(11, "2 = perfect")
    tab(11, "3 = random")
    tab(11, "4 = sequential", "-" * 31)
  end

  # Method to handle player X selection
  def select_x
    print " Please select the X player: "
    p1 = gets.chomp
    case p1
      when "1" then @p1_type = "human"
      when "2" then @p1_type = "perfect"
      when "3" then @p1_type = "random"
      when "4" then @p1_type = "sequential"
      else @p1_type = "invalid_p1"
    end
    invalid_player?(@p1_type)
  end

  # Method to handle player O selection
  def select_o
    print " Please select the O player: "
    p2 = gets.chomp
    case p2
      when "1" then @p2_type = "human"
      when "2" then @p2_type = "perfect"
      when "3" then @p2_type = "random"
      when "4" then @p2_type = "sequential"
      else @p2_type = "invalid_p2"
    end
    invalid_player?(@p2_type)
  end

  # Method to handle invalid input during player selection
  def invalid_player?(player_type)
    unless player_type =~ /invalid/
      if player_type == @p1_type
        puts "\n"
        tab(12, "Great!!!")
        tab(5, "X is a #{@p1_type} player.", "-" * 31)
      elsif player_type == @p2_type
        puts "\n"
        tab(10, "Excellent!!!")
        tab(5, "O is a #{@p2_type} player.", "-" * 31)
      end
    else
      puts "\n"
      puts " Invalid selection - try again!"
      player_type == "invalid_p1" ? select_x : select_o
    end
  end

  # Method to display header and legend
  def header
    border(31)
    tab(10, "Tic Tac Toe")
  end

  # Method to display cumulative score
  def scorekeeping(x_score, o_score)
    border(31)
    tab(4, "X Wins: #{x_score}     O Wins: #{o_score}", "-" * 31)
    puts "\n"
  end

  # Method to display location legend
  def legend
    border(31)
    tab(11, "Locations", "-" * 31)
    tab(5, "Top row:    t1, t2, t3")
    tab(5, "Middle row: m1, m2, m3")
    tab(5, "Bottom row: b1, b2, b3", "-" * 31)
  end

  # Method to output the game board
  def output_board(board, x_score, o_score)
    clear_screen
    header
    scorekeeping(x_score, o_score)
    spaced = []
    board.each { |mark| mark == "" ? spaced.push(" ") : spaced.push(mark) }
    rows = spaced.each_slice(3).to_a
    rows.each_with_index do |row, index|
      index < 2 ? (tab(11, row.join(" | ")); tab(11, "-" * 9)) : tab(11, row.join(" | "))
    end
    puts "\n"
    legend
  end

  # Method to provide feedback on move selection
  def move_status(round, mark, move, taken)
    if round > 1
      previous = round - 1
      tab(5, "Round #{previous}: #{mark} selected #{move}", "-" * 31)
      if taken == true
        tab(3, "That position isn't open!")
        tab(5, "* Please try again *", "-" * 31)
      end
    end
  end

  # Method to handle pause to display computer player move
  def computer
    tab(4, "Press Enter for AI move.")
    input = gets
  end

  # Method to provide endgame summary feedback
  def output_results(x_won, o_won, win, round, mark, move)
    tab(5, "Round #{round}: #{mark} selected #{move}", "-" * 31)
    if x_won == true
      tab(7, "Player 1 (X) won!", "\n")
      tab(3, "Winning moves: #{win}", "-" * 31)
    elsif o_won == true
      tab(7, "Player 2 (O) won!", "\n")
      tab(3, "Winning moves: #{win}", "-" * 31)
    else
      tab(9, "It was a tie!", "-" * 31)
    end
  end

  # Method to display cumulative gameplay options
  def play_again?
    tab(4, "Press 'y' to play again.")
    tab(7, "Press 'q' to quit.", "\n")
    @key = STDIN.getch
  end

end

# Sandbox testing
# board = Board.new
# console = Console.new
# position = Position.new
# # board.game_board = ["", "", "X", "", "X", "O", "X", "", "O"]  # X win
# # board.game_board = ["X", "", "", "O", "O", "O", "", "X", "X"]  # O win
# # board.game_board = ["O", "X", "O", "", "X", "", "X", "X", "O"]  # X win
# board.game_board = ["O", "X", "X", "", "O", "", "X", "", "O"]  # O win
# x_won = board.x_won?(board.get_x)
# o_won = board.o_won?(board.get_o)
# win = board.get_win
# translated = position.map_win(win)
# console.output_results(x_won, o_won, translated)
# console.invalid_player?("invalid_p1")