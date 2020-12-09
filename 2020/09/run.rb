require_relative "lib"

input = File.readlines("input.txt").map { |line| line.chomp.to_i }

invalid_num = first_invalid_num(input, 25)

puts invalid_num

subset = subset_with_sum(input, invalid_num).sort

puts subset[0] + subset[-1]

