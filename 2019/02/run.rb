require_relative "lib"

input = File.read("input.txt").chomp.split(",").map(&:to_i)

puts compute(dup_with_noun_and_verb(input, 12, 2))[0]
puts find_noun_and_verb(input, 19690720)
