require_relative "lib"

lines = File.readlines("input.txt").map(&:chomp)

chain = Chain.new(lines)

puts chain.ore_amount

puts chain.fuel_amount(1000000000000)
