require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal([4,8,2,2,6,1,5,8], fft_phase([1,2,3,4,5,6,7,8]))
assert_equal("01029498", fft_apply([1,2,3,4,5,6,7,8], 4))
assert_equal("24176176", fft_apply("80871224585914546619083218645595".chars.map(&:to_i), 100))

assert_equal("84462026", fft_apply_v2("03036732577212944063491565474664".chars.map(&:to_i) * 10000, 100, 303673))
assert_equal("53553731", fft_apply_v2("03081770884921959731165446850517".chars.map(&:to_i) * 10000, 100, 308177))
