require_relative "lib"

instructions = File.readlines("input.txt").map(&:chomp)

stack = shuffle((0...10007).to_a, instructions)
puts stack.index(2019)
c, d = c_d_instructions(instructions, 10007)
puts (c * 2019 + d) % 10007

length = 119315717514047
repeated_instructions_stack = length / 2
times_apply = 101741582076661 % repeated_instructions_stack
c, d = c_d_instructions(instructions, length)
index = 2020
times_apply.times do |i|
  index = (c * index + d) % length # :(
end
puts index
