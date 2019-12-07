require_relative "lib"

input = File.read("input.txt").chomp.split(",").map(&:to_i)

puts max_thruster_signal(input)
puts max_feedback_thruster_signal(input)
