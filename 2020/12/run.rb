require_relative "lib"

input = File.readlines("input.txt").map(&:chomp)

puts manhattan_distance_to(input)
puts navigate(input)
