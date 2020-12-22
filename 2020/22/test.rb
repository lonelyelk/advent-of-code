require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = "Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10
"

dealed = parse_input(input)

assert_equal 306, score(play(dealed).detect { |hand| !hand.empty? }), "Wrong score"
assert_equal 291, score(play_recursive(dealed).detect { |hand| !hand.empty? }), "Wrong score"

input = "Player 1:
43
19

Player 2:
2
29
14
"

dealed = parse_input(input)
puts play_recursive(dealed)
