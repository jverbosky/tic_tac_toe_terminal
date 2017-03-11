# string = ["Tic Tac Toe", "\n", "-" * 31]

# string.each_with_index do |e, i|
#   if i == 0
#     print " " * 10 + e
#   else
#     print e
#   end
# end

# string.each_with_index { |e, i| i == 0 ? (print " " * 10 + e) : (print e) }


def tab(n, *string)
  string.each_with_index { |e, i| i == 0 ? (print " " * 10 + e) : (print e) }
end

tab(10, "Tic Tac Toe", "\n", "-" * 31)