require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

puts scan(prog)
puts find_santa_fit(prog).inspect
puts scan2(prog, 923, 1141)
