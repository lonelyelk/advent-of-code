require_relative "lib"

input = File.read("input.txt").chomp
ts = TileSet.new(input)

puts ts.find_corners
puts ts.count_water_roughness!
