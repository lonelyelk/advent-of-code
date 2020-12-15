require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal 0, memory_game([0,3,6], 10), "Wrong nunmber"
assert_equal 436, memory_game([0,3,6], 2020), "Wrong nunmber"
assert_equal 1, memory_game([1,3,2], 2020), "Wrong nunmber"
assert_equal 10, memory_game([2,1,3], 2020), "Wrong nunmber"
assert_equal 27, memory_game([1,2,3], 2020), "Wrong nunmber"
assert_equal 78, memory_game([2,3,1], 2020), "Wrong nunmber"
assert_equal 438, memory_game([3,2,1], 2020), "Wrong nunmber"
assert_equal 1836, memory_game([3,1,2], 2020), "Wrong nunmber"

assert_equal 175594, memory_game([0,3,6], 30000000), "Wrong nunmber"
