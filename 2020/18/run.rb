require_relative "lib"

instructions = File.readlines("input.txt").map(&:chomp)

puts instructions.inject(0) { |sum, instr| sum + calc(instr) }
puts instructions.inject(0) { |sum, instr| sum + calc_plus(instr) }
