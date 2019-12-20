require_relative "lib"

input = File.readlines("input.txt").map { |line| line.chomp.chars }

# puts build_map(input).inspect
sol = solve(input)
puts sol.inspect
puts sol.inject(0) { |acc, pt| acc + pt[1] }
