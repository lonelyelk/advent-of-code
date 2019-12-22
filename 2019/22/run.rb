require_relative "lib"

instructions = File.readlines("input.txt").map(&:chomp)

stack = shuffle((0...10007).to_a, instructions)
puts stack.index(2019)

repeated_instructions_stack = 1
index = index_before_shuffle(10037, 20, instructions)
while index != 20
  repeated_instructions_stack += 1
  index = index_before_shuffle(10037, index, instructions)
  # puts "#{repeated_instructions_stack} index = #{index}"
end

puts repeated_instructions_stack
