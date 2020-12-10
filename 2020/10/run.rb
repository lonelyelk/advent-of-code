require_relative "lib"

input = File.readlines("input.txt").map { |line| line.chomp.to_i }

diffs = joltage_diffs(input)

puts diffs[1] * diffs[3]

puts solutions_count(input)
