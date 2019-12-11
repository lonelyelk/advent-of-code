require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

puts run(prog).map { |point| point[0..1] }.uniq.length
plot(run(prog, 1)).each do |line|
  puts line
end
