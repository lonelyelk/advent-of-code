require_relative "lib"

input = File.read("input.txt")
parsed = parse_input(input)
possible = possible_allergens(parsed)

puts no_allergens(parsed, possible).length
puts definite_allergens(possible)
