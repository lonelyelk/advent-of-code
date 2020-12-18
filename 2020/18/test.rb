require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal 26, calc("2 * 3 + (4 * 5)"), "Wrong result"
assert_equal 437, calc("5 + (8 * 3 + 9 + 3 * 4 * 3)"), "Wrong result"
assert_equal 12240, calc("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"), "Wrong result"
assert_equal 13632, calc("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"), "Wrong result"

assert_equal 51, calc_plus("1 + (2 * 3) + (4 * (5 + 6))"), "Wrong result"
assert_equal 46, calc_plus("2 * 3 + (4 * 5)"), "Wrong result"
assert_equal 1445, calc_plus("5 + (8 * 3 + 9 + 3 * 4 * 3)"), "Wrong result"
assert_equal 669060, calc_plus("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"), "Wrong result"
assert_equal 23340, calc_plus("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"), "Wrong result"
