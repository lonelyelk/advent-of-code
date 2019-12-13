require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

intcode = Intcode.new(prog: prog)

intcode.compute_continue

arr = intcode.flush_output

puts arr.each_slice(3).map(&:last).count { |n| n == 2 }
