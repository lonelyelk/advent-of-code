require_relative "lib"

input = File.read("input.txt")

puts yes_count(input, :any)
puts yes_count(input, :all)
