require_relative "lib"

instructions = File.readlines("input.txt").map(&:chomp)

stack = shuffle((0...10007).to_a, instructions)
puts stack.index(2019)
c, d = c_d_instructions(instructions, 10007)
puts rev_index(instructions, 10007, 1, (c * 2019 + d) % 10007)

length = 119315717514047
times_apply = 101741582076661
index = 2020
puts rev_index(instructions, length, times_apply, index)
