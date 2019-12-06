require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal 2, fuel(12), "Wrong fuel"
assert_equal 2, fuel(14), "Wrong fuel"
assert_equal 654, fuel(1969), "Wrong fuel"
assert_equal 33583, fuel(100756), "Wrong fuel"

assert_equal 2, full_fuel(14), "Wrong full fuel"
assert_equal 966, full_fuel(1969), "Wrong full fuel"
assert_equal 50346, full_fuel(100756), "Wrong full fuel"
