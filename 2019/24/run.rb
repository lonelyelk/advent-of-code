require_relative "lib"

input = File.readlines("input.txt").map { |line| line.chomp.chars }

puts bd_rating_for_twice(input)
puts count_bugs_in_recursive_steps(input, 200)
