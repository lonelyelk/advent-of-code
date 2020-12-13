require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

timestamp = 939
buses = "7,13,x,x,59,x,31,19"

assert_equal 295, next_bus(timestamp, buses), "Wrong bus"
assert_equal 1068781, crt_timestamp_for(buses), "Wrong timestams"
