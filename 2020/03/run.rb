require_relative "lib"

input = File.readlines("input.txt").map { |line| line.chomp }

puts trees_count(input)

check = trees_count(input, 1, 1) *
  trees_count(input, 3, 1) *
  trees_count(input, 5, 1) *
  trees_count(input, 7, 1) *
  trees_count(input, 1, 2)

puts check
