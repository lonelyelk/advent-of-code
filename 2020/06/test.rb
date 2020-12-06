require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = "abc

a
b
c

ab
ac

a
a
a
a

b"

assert_equal 11, yes_count(input, :any), "Wrong yes count"
assert_equal 6, yes_count(input, :all), "Wrong yes count"
