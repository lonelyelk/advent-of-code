require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

intcode = Intcode.new(prog: prog)
intcode.compute_continue
output = intcode.flush_output

puts output.map { |out| out.chr }.join

puts alignment(output)
