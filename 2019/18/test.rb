require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = <<MIN
########################
#...............b.C.D.f#
#.######################
#.....@.a.B.c.d.A.e.F.g#
########################
MIN

sol = solve(input.chomp.split("\n").map(&:chars))
puts sol.inspect
puts sol.inject(0) { |acc, pt| acc + pt[1] }

input = <<MIN
#################
#i.G..c...e..H.p#
########.########
#j.A..b...f..D.o#
########@########
#k.E..a...g..B.n#
########.########
#l.F..d...h..C.m#
#################
MIN

sol = solve(input.chomp.split("\n").map(&:chars))
puts sol.inspect
puts sol.inject(0) { |acc, pt| acc + pt[1] }

input = <<MIN
########################
#@..............ac.GI.b#
###d#e#f################
###A#B#C################
###g#h#i################
########################
MIN

sol = solve(input.chomp.split("\n").map(&:chars))
puts sol.inspect
puts sol.inject(0) { |acc, pt| acc + pt[1] }
