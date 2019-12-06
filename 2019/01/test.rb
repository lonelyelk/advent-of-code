require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal 2, fuel(12), "Fuel required for a module with weight 12 is 2"
assert_equal 2, fuel(14), "Fuel required for a module with weight 14 is 2"
assert_equal 654, fuel(1969), "Fuel required for a module with weight 1969 is 654"
assert_equal 33583, fuel(100756), "Fuel required for a module with weight 100756 is 33583"

assert_equal 2, full_fuel(14), "Full fuel required for a module with weight 14 is 2"
assert_equal 966, full_fuel(1969), "Full fuel required for a module with weight 1969 is 966"
assert_equal 50346, full_fuel(100756), "Full fuel required for a module with weight 100756 is 50346"
