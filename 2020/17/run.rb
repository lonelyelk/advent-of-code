require_relative "lib"

input = File.read("input.txt")
field = init_field(input, 6)
6.times { field = cycle(field) }

puts count(field)

field = init_field4(input, 6)
6.times { field = cycle4(field) }

puts count4(field)
