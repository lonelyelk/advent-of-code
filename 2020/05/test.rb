require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal 357, seat_id("FBFBBFFRLR"), "Wrong seat id"
assert_equal 567, seat_id("BFFFBBFRRR"), "Wrong seat id"
assert_equal 119, seat_id("FFFBBBFRRR"), "Wrong seat id"
assert_equal 820, seat_id("BBFFBBFRLL"), "Wrong seat id"
