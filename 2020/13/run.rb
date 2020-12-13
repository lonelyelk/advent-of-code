require_relative "lib"

timestamp, buses = File.readlines("input.txt").map(&:chomp)

puts next_bus(timestamp.to_i, buses)
puts crt_timestamp_for(buses)
