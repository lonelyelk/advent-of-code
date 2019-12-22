require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal([0,7,4,1,8,5,2,9,6,3], deal_with_inc((0...10).to_a, 3))
assert_equal([0,3,6,9,2,5,8,1,4,7], deal_with_inc((0...10).to_a, 7))

assert_equal([0,7,4,1,8,5,2,9,6,3], (0...10).to_a.map { |index| index_before_deal_with_inc(10, index, 3) })
assert_equal([0,3,6,9,2,5,8,1,4,7], (0...10).to_a.map { |index| index_before_deal_with_inc(10, index, 7) })

input = <<MIN
deal with increment 7
deal into new stack
deal into new stack
MIN

assert_equal([0,3,6,9,2,5,8,1,4,7], shuffle((0...10).to_a, input.chomp.split("\n")))

input = <<MIN
deal into new stack
cut -2
deal with increment 7
cut 8
cut -4
deal with increment 7
cut 3
deal with increment 9
deal with increment 3
cut -1
MIN

assert_equal([9,2,5,8,1,4,7,0,3,6], shuffle((0...10).to_a, input.chomp.split("\n")))

instructions = File.readlines("input.txt").map(&:chomp)
stack = shuffle((0...10007).to_a, instructions)
assert_equal(stack, (0...10007).to_a.map { |index| index_before_shuffle(10007, index, instructions) })

puts shuffle2(2019, instructions) % 10007
