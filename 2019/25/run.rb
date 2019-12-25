require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

puts DroidControl.new(prog: prog, all: true).pass_security_check.inspect
puts DroidControl.new(prog: prog).run
