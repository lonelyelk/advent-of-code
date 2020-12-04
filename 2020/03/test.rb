require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

trees = [
  '..##.......',
  '#...#...#..',
  '.#....#..#.',
  '..#.#...#.#',
  '.#...##..#.',
  '..#.##.....',
  '.#.#.#....#',
  '.#........#',
  '#.##...#...',
  '#...##....#',
  '.#..#...#.#',
]

assert_equal 7, trees_count(trees), "Wrong trees count"

check = trees_count(trees, 1, 1) *
  trees_count(trees, 3, 1) *
  trees_count(trees, 5, 1) *
  trees_count(trees, 7, 1) *
  trees_count(trees, 1, 2)

assert_equal 336, check, "Wrong trees check"
