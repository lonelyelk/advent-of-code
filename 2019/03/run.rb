require_relative "lib"

w1, w2 = File.readlines("input.txt").map { |line| line.chomp.split(",") }

puts min_distance(w1, w2)
puts min_steps(w1, w2)
