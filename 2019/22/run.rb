require_relative "lib"

instructions = File.readlines("input.txt").map(&:chomp)

stack = shuffle((0...10007).to_a, instructions)
puts stack.index(2019)
c, d = c_d_instructions(instructions, 10007)
puts (c * 2019 + d) % 10007

length = 119315717514047
repeated_instructions_stack = length / 2
times_apply = 101741582076661 % repeated_instructions_stack
index = 2020
shift = 1
c, d = c_d_instructions(instructions, length)
while shift < times_apply
  if times_apply & shift > 0
    index = (c * index + d) % length # :(
  end
  d = (c * d) % length
  c = (c * c) % length
  shift <<= 1
  # puts shift
end
puts index
