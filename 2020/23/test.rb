require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = "389125467"

assert_equal "92658374", crab_game(input, 10), "Wrong result"
assert_equal 149245887792, crab_game2(input, 10000000), "Wrong result"
