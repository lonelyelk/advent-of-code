require_relative "lib"

input = File.read("input.txt").chomp.chars.map(&:to_i)

puts fft_apply(input, 100)
puts fft_apply(input * 10000, 100)[0...8].join
