require_relative "lib"

input = File.read("input.txt")
game = GameOfSeats.new(input)

puts game.stabilize!

game = GameOfSeats2.new(input)

puts game.stabilize!
