require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal([4,8,2,2,6,1,5,8], fft_phase([1,2,3,4,5,6,7,8], [0,1,0,-1]))
assert_equal([0,1,0,2,9,4,9,8], fft_apply([1,2,3,4,5,6,7,8], [0,1,0,-1], 4))
assert_equal([2,4,1,7,6,1,7,6], fft_apply("80871224585914546619083218645595".chars.map(&:to_i), [0,1,0,-1], 100)[0...8])
