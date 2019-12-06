require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal(
  [2,0,0,0,99],
  compute([1,0,0,0,99]),
  "Computation failed",
)
assert_equal(
  [2,3,0,6,99],
  compute([2,3,0,3,99]),
  "Computation failed",
)
assert_equal(
  [2,4,4,5,99,9801],
  compute([2,4,4,5,99,0]),
  "Computation failed",
)
assert_equal(
  [30,1,1,4,2,5,6,0,99],
  compute([1,1,1,4,99,5,6,0,99]),
  "Computation failed",
)
assert_equal(
  [3500,9,10,70,2,3,11,0,99,30,40,50],
  compute([1,9,10,3,2,3,11,0,99,30,40,50]),
  "Computation failed",
)

assert_equal(
  1202,
  find_noun_and_verb(File.read("input.txt").chomp.split(",").map(&:to_i), 2842648),
  "Wrong noun and verb",
)
