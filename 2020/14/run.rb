require_relative "lib"

instructions = File.readlines("input.txt").map(&:chomp)

puts init(instructions)
puts init_v2(instructions)
