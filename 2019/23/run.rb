require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

puts IntcodeNetwork.new(prog: prog).run(p1: true)
puts IntcodeNetwork.new(prog: prog).run
