require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = "nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6"

assembly = Assembly.new(input)

assert_equal 5, assembly.execute, "Wrong acc value"
