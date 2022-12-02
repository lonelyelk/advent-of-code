# frozen_string_literal: true

# https://adventofcode.com/2021/day/1
module Day01
  def process_input(str)
    str.split("\n").reject(&:empty?).map(&:to_i)
  end

  def problem1(input)
    input.each_with_index.inject(0) do |acc, (m, i)|
      if i.positive? && m > input[i - 1]
        acc + 1
      else
        acc
      end
    end
  end

  def problem2(input)
    input.each_cons(3).with_object({ last: nil, count: 0 }) do |m, obj|
      measurement = m.inject(:+)
      obj[:count] += 1 if !obj[:last].nil? && obj[:last] < measurement
      obj[:last] = measurement
    end[:count]
  end
end
