require_relative "lib"

input = File.read("input.txt").chomp.chars.map(&:to_i)

puts fft_apply(input, 100)
puts fft_apply_v2(input * 10000, 100, input[0...7].join.to_i)
