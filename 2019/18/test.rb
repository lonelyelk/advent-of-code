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

# assert_equal(132, Pathfinder.new.solve(input.chomp.split("\n").map(&:chars))[:steps_count], "Wrong steps count")

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

# assert_equal(136, Pathfinder.new.solve(input.chomp.split("\n").map(&:chars))[:steps_count], "Wrong steps count")

input = <<MIN
########################
#@..............ac.GI.b#
###d#e#f################
###A#B#C################
###g#h#i################
########################
MIN

# assert_equal(81, Pathfinder.new.solve(input.chomp.split("\n").map(&:chars))[:steps_count], "Wrong steps count")

input = <<MIN
#######
#a.#Cd#
##@#@##
#######
##@#@##
#cB#Ab#
#######
MIN

assert_equal(8, Pathfinder.new.solve_bots(input.chomp.split("\n").map(&:chars))[:steps_count], "Wrong steps count")

input = <<MIN
###############
#d.ABC.#.....a#
######@#@######
###############
######@#@######
#b.....#.....c#
###############
MIN

assert_equal(24, Pathfinder.new.solve_bots(input.chomp.split("\n").map(&:chars))[:steps_count], "Wrong steps count")

input = <<MIN
#############
#DcBa.#.GhKl#
#.###@#@#I###
#e#d#####j#k#
###C#@#@###J#
#fEbA.#.FgHi#
#############
MIN

assert_equal(32, Pathfinder.new.solve_bots(input.chomp.split("\n").map(&:chars))[:steps_count], "Wrong steps count")

input = '#############
#g#f.D#..h#l#
#F###e#E###.#
#dCba@#@BcIJ#
#############
#nK.L@#@G...#
#M###N#H###.#
#o#m..#i#jk.#
#############'


assert_equal(72, Pathfinder.new.solve_bots(input.chomp.split("\n").map(&:chars))[:steps_count], "Wrong steps count")
