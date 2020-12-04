require_relative "lib"

input = File.read("input.txt")

puts valid_pass_count(input)
puts valid_pass2_count(input)
