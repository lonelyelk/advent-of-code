require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = <<BUGS
....#
#..#.
#..##
..#..
#....
BUGS

output = <<MORE
#..#.
####.
###.#
##.##
.##..
MORE

gol = GameOfLife.new(input.split("\n").map(&:chars))

gol.step
assert_equal(output.chomp, gol.to_s, "Wrong field state")

assert_equal(2129920, bd_rating_for_twice(input.split("\n").map(&:chars)), "Wrong bd rating")
