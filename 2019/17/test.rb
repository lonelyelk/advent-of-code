require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

cam = <<CAM
..#..........
..#..........
#######...###
#.#...#...#.#
#############
..#...#...#..
..#####...^..
CAM

output = cam.chars.map(&:ord)

assert_equal(76, alignment(output), "Wrong alignment")
