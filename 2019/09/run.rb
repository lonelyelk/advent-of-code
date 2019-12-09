require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

intcode = Intcode.new(prog: prog, input: [1])
intcode.compute_continue
puts intcode.halt?

puts intcode.flush_output.inspect

intcode = Intcode.new(prog: prog, input: [2])
intcode.compute_continue
puts intcode.halt?

puts intcode.flush_output.inspect
