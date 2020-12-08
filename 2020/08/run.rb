require_relative "lib"

input = File.read("input.txt")
assembly = Assembly.new(input)

puts assembly.execute.inspect
puts assembly.fix.inspect
