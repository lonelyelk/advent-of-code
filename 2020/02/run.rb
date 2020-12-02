require_relative "lib"

input = File.readlines("input.txt").map { |line| line.chomp }

puts valid_passwords_count(input)
puts new_valid_passwords_count(input)
