require_relative "lib"

pubs = File.read("input.txt").chomp.split("\n").map(&:to_i)
cycles = pubs.map { |pub| babystep_giantstep(7, pub, 20201227) }

puts cycles.inspect
puts pubs[0].pow(cycles[1], 20201227)
puts pubs[1].pow(cycles[0], 20201227)
