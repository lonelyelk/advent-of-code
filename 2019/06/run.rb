require_relative "lib"

input = File.readlines("input.txt").map(&:chomp)
map = orbit_map(input)

puts total_orbits(map)
puts possible_distances(map).first

