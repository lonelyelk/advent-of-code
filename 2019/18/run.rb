require_relative "lib"

input = File.readlines("input.txt").map { |line| line.chomp.chars }

puts Pathfinder.new.solve(input)

input = File.readlines("input_p2.txt").map { |line| line.chomp.chars }

puts Pathfinder.new.solve_bots(input)
