require_relative "lib"

input = File.read("input.txt")
dealed = parse_input(input)

puts score(play(dealed).detect { |hand| !hand.empty? })
# puts score(play_recursive(dealed).detect { |hand| !hand.empty? })
# puts analyze_recursive(dealed)
