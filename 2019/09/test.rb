require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

prog = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]
intcode = Intcode.new(prog: prog)
intcode.compute_continue

assert_equal(
  prog,
  intcode.flush_output,
  "Wrong output",
)

prog = [1102,34915192,34915192,7,4,7,99,0]
intcode = Intcode.new(prog: prog)
intcode.compute_continue

assert_equal(
  1219070632396864,
  intcode.output,
  "Wrong output",
)

prog = [104,1125899906842624,99]
intcode = Intcode.new(prog: prog)
intcode.compute_continue

assert_equal(
  1125899906842624,
  intcode.output,
  "Wrong output",
)
