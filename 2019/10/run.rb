require_relative "lib"

map = File.read("input.txt")

locations = rate_locations(process_input(map))
max_visible = locations.map(&:max).max
puts max_visible
y = locations.index { |line| line.include?(max_visible) }
x = locations[y].index(max_visible)
puts "(#{x}, #{y})"

visible = remove_all_hidden(process_input(map), x, y)
removed = assign_angle_to_all(visible, x, y)

puts removed[199].inspect
