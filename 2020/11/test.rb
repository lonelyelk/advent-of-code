require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = "L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
"

game = GameOfSeats.new(input)

assert_equal 37, game.stabilize!, "Wrong stabilization time"

game = GameOfSeats2.new(input)

assert_equal 26, game.stabilize!, "Wrong stabilization time"
