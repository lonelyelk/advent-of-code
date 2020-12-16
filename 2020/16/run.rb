require_relative "lib"

instructions = File.readlines("input.txt").map(&:chomp)

index = instructions.index("")
rules = instructions[0..(index-1)]
index = instructions.index("nearby tickets:")
nearby_tickets = instructions[(index+1)..-1]
index = instructions.index("your ticket:")
my_ticket = instructions[index+1]

puts invalid_sum(rules, nearby_tickets)
puts(parse_ticket(rules, nearby_tickets, my_ticket).inject(1) do |mul, (rule, val)|
  if rule.to_s.match(/^departure/)
    mul * val
  else
    mul
  end
end)
