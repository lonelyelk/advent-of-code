require_relative "lib"

input = File.readlines("input.txt").map(&:chomp)
seat_ids = input.map { |str| seat_id(str) }.sort

puts seat_ids.max
seat_ids.each_with_index do |seat, index|
  if index > 0 && seat == seat_ids[index - 1] + 2
    puts seat - 1
    exit
  end
end
