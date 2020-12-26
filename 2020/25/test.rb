require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

pubs = [5764801, 17807724]
cycles = pubs.map { |pub| babystep_giantstep(7, pub, 20201227) }
assert_equal 8, cycles[0], "Wrong cycles count"
assert_equal 11, cycles[1], "Wrong cycles count"
assert_equal 14897079, pubs[0].pow(cycles[1], 20201227), "Wrong private key"
assert_equal 14897079, pubs[1].pow(cycles[0], 20201227), "Wrong private key"
