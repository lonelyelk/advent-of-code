require_relative "lib"

input = File.read("input.txt").chomp.chars.map(&:to_i)

puts fft_apply(input, [0,1,0,-1], 100)[0...8].join
