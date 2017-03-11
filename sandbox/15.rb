Research on why tests 27, 32 & 33 broke after adding logic for 103 - 104

#-------------------------------------------------------

87 - 88 > 103 - 104

X should take corner that not opposite from O corner

O X -
X X O  # both boards same in r7
- O -

#-------------------------------------------------------

  27      32     33

X O X   X O -   X O X
O - -   O X -   O X -
X - O   X - O   - - O

#-------------------------------------------------------

Broken tests due to pattern matching, but after further review determined that logic
added for tests 103 - 104 (documented in 14.rb) was quite unnecessary as the board layout
is completely symmetrical and selecting a random corner is truly a moot point.

Decided to back out logic developed for 103 - 104 and go with specific edge selection.