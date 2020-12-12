require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

instructions = [
  "F10",
  "N3",
  "F7",
  "R90",
  "F11",
]

assert_equal 25, manhattan_distance_to(instructions), "Wrong manhattan distance"
assert_equal 286, navigate(instructions), "Wrong manhattan distance"
