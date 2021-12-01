def process_input(str)
  str.split("\n").reject(&:empty?).map(&:to_i)
end

def problem_1(input)
  input.each_with_index.inject(0) do |acc, (m, i)|
    if i > 0 && m > input[i-1]
      acc+1
    else
      acc
    end
  end
end

def problem_2(input)
  input.each_cons(3).each_with_object({last: nil, count: 0}) do |m, obj|
    measurement = m.inject(:+)
    if !obj[:last].nil? && obj[:last] < measurement
      obj[:count] += 1
    end
    obj[:last] = measurement
  end[:count]
end
