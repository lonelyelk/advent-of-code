require_relative "lib"

input = File.readlines("input.txt").map(&:chomp)
parsed_rules = parse_rules(input)

puts outer_bag_count(parsed_rules, "shiny gold")
puts inner_bag_count(parsed_rules, "shiny gold")
