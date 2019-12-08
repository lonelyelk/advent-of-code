require_relative "lib"

input = File.read("input.txt").chomp.split(",").map(&:to_i)

puts compute(input, [1]).last
puts compute(input, [5]).last
