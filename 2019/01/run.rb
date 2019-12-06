require_relative "lib"

input = File.readlines("input.txt").map { |line| line.chomp.to_i }

puts input.inject(0) { |acc, m| acc + fuel(m) }
puts input.inject(0) { |acc, m| acc + full_fuel(m) }
