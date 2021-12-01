input_test = [
  199,
  200,
  208,
  210,
  200,
  207,
  240,
  269,
  260,
  263,
]

input = File.readlines("input.txt").map { |l| l.chomp.to_i }

puts(input.each_with_index.inject(0) do |acc, (m, i)|
  if i.zero?
    0
  elsif m > input[i-1]
    acc+1
  else
    acc
  end
end)

puts(input.each_cons(3).each_with_object({last: nil, count: 0}) do |m, obj|
  measurement = m.inject(:+)
  if !obj[:last].nil? && obj[:last] < measurement
    obj[:count] += 1
  end
  obj[:last] = measurement
end)
