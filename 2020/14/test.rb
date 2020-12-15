require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

instructions = "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
".split("\n").map(&:chomp)

assert_equal 165, init(instructions), "Wrong init result"

instructions = "mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
".split("\n").map(&:chomp)

assert_equal 208, init_v2(instructions), "Wrong init result"
