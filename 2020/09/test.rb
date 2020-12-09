require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = [
  35,
  20,
  15,
  25,
  47,
  40,
  62,
  55,
  65,
  95,
  102,
  117,
  150,
  182,
  127,
  219,
  299,
  277,
  309,
  576,
]

assert_equal 127, first_invalid_num(input, 5), "Wrong invalid number"
assert_equal [15, 25, 47, 40], subset_with_sum(input, 127), "Wroing subset"
