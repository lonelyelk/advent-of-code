require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

intcode = Intcode.new(prog: prog)
intcode.compute_continue
output = intcode.flush_output

# puts output.map { |out| out.chr }.join

puts alignment(output)

input = (find_functions_input(trajectory(output)) + "\nn\n")
prog[0] = 2

intcode = Intcode.new(prog: prog, input: input.chars.map(&:ord))
intcode.compute_continue

puts intcode.halt?
puts intcode.flush_output.last
