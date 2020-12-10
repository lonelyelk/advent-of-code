require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = [
  16,
  10,
  15,
  5,
  1,
  11,
  7,
  19,
  6,
  12,
  4,
]

assert_equal ({ 1 => 7, 2 => 0, 3 => 5 }), joltage_diffs(input), "Wrong joltage diffs"
assert_equal 8, solutions_count(input), "Wrong solutions count"

input = [
  28,
  33,
  18,
  42,
  31,
  14,
  46,
  20,
  48,
  47,
  24,
  23,
  49,
  45,
  19,
  38,
  39,
  11,
  1,
  32,
  25,
  35,
  8,
  17,
  7,
  9,
  4,
  2,
  34,
  10,
  3,
]

assert_equal ({ 1 => 22, 2 => 0, 3 => 10 }), joltage_diffs(input), "Wrong joltage diffs"
assert_equal 19208, solutions_count(input), "Wrong solutions count"
