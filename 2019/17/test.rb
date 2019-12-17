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

cam = <<CAM
#######...#####
#.....#...#...#
#.....#...#...#
......#...#...#
......#...###.#
......#.....#.#
^########...#.#
......#.#...#.#
......#########
........#...#..
....#########..
....#...#......
....#...#......
....#...#......
....#####......
CAM

output = cam.chars.map(&:ord)

assert_equal("R,8,R,8,R,4,R,4,R,8,L,6,L,2,R,4,R,4,R,8,R,8,R,8,L,6,L,2", trajectory(output).join(","), "Wrong trajectory")
