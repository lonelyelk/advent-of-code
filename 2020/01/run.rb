require_relative "lib"

input = File.readlines("input.txt").map { |line| line.chomp.to_i }

puts fix_report(input)
puts fix_report3(input)
