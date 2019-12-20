require_relative "lib"

map = File.readlines("input.txt").map{ |line| line.chomp.chars }

puts path(map)
puts path_recursive(map)
