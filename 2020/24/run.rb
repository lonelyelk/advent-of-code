require_relative "lib"

input = File.read("input.txt")

puts flipped_tiles_count(input)

b_t = b_tiles(input)
100.times do |i|
  b_t = game_of_tiles_round(b_t)
end

puts b_t.select { |_, v| v }.length
