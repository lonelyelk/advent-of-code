require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

intcode = Intcode.new(prog: prog)
intcode.compute_continue
arr = intcode.flush_output

puts arr.each_slice(3).map(&:last).count { |n| n == 2 }

prog[0] = 2

intcode = Intcode.new(prog: prog)
screen = nil
score = nil
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].each do |input|
  intcode.compute_continue
  intcode.input(input)
  screen, score = plot(intcode.flush_output, screen, score)
  sleep 1
end
