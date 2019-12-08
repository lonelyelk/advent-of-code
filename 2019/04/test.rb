require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_true(pass_p1?(number_to_digits("111111")), "Should pass")
assert_false(pass_p1?(number_to_digits("223450")), "Should not pass")
assert_false(pass_p1?(number_to_digits("123789")), "Should not pass")

assert_true(pass_p2?(number_to_digits("112233")), "Should pass")
assert_false(pass_p2?(number_to_digits("123444")), "Should not pass")
assert_true(pass_p2?(number_to_digits("111122")), "Should pass")
