require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

map, length = draw_map(prog)

puts length
puts oxigen_fill(map)
