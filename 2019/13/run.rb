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
while !intcode.halt?
  intcode.compute_continue
  intcode.prg[391] = -1 if intcode.prg[389] == 20 # cheat!

  intcode.input(0)
  screen, score = plot(intcode.flush_output, screen, score)
  # sleep 0.01
end

puts score
