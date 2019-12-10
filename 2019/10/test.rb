require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal(
  [[2,2], [1,1], [0,0]],
  hidden_locations(4,4,3,3,0,0,5,5),
  "Wrong hidden locations",
)

assert_equal(
  [[0,4]],
  hidden_locations(6,0,3,2,0,0,6,6),
  "Wrong hidden locations",
)

map = <<MAP
.#..#
.....
#####
....#
...##
MAP
map_removed = <<MAP
.#..#
.....
###..
....#
...##
MAP
map_all_removed = <<MAP
.#..#
.....
...##
....#
...#.
MAP

assert_equal(
  map_removed.chomp,
  output(remove_hidden(process_input(map), 1, 2, 2, 2)),
  "Wrong hidden locations",
)
assert_equal(
  map_all_removed.chomp,
  output(remove_all_hidden(process_input(map), 4, 2)),
  "Wrong hidden locations",
)

assert_equal(
  [
    [0,7,0,0,7],
    [0,0,0,0,0],
    [6,7,7,7,5],
    [0,0,0,0,7],
    [0,0,0,8,7],
  ],
  rate_locations(process_input(map)),
  "Wrong rated locations",
)

map = <<MAP
.#....#####...#..
##...##.#####..##
##...#...#.#####.
..#.....X...###..
..#.#.....#....##
MAP

assert_equal(
  [[8,1],[9,0],[9,1],[10,0],[9,2]],
  assign_angle_to_all(remove_all_hidden(process_input(map), 8, 3), 8, 3).map { |point| point[0..1] }[0..4],
  "Wrong order of locations",
)
