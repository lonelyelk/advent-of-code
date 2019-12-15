require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

draw_map(prog)
