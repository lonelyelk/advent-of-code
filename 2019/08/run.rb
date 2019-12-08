require_relative "lib"

input = File.read("input.txt").chomp
image = Image.read(buffer: input, width: 25, height: 6)

puts image.check_num
image.render
