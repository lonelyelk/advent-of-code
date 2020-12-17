require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = ".#.
..#
###
"
field = init_field(input, 6)
field = cycle(field)

assert_equal 11, count(field), "Wrong number of active cubes"

5.times { field = cycle(field) }

assert_equal 112, count(field), "Wrong number of active cubes"

field = init_field4(input, 6)
6.times { field = cycle4(field) }

assert_equal 848, count4(field), "Wrong number of active cubes"
