# frozen_string_literal: true

# https://adventofcode.com/2024/day/7
module Year2024
  module Day07
    def process_input(str)
      str.split("\n").map do |line|
        res, list = line.split(": ", 2)
        [res.to_i, list.split.map(&:to_i)]
      end
    end

    def problem1(input)
      input.sum do |(res, list)|
        curr = -1
        (2**(list.size - 1)).times do |i|
          curr, = list.each_with_index.inject do |(acc, j), (num, k)|
            [apply_operator((i >> j) & 1, acc, num), k]
          end
          break if curr == res
        end
        curr == res ? res : 0
      end
    end

    def problem2(input)
      input.sum do |(res, list)|
        curr = -1
        (3**(list.size - 1)).times do |i|
          curr, = list.each_with_index.inject do |(acc, j), (num, k)|
            [apply_operator((i / 3**j) % 3, acc, num), k]
          end
          break if curr == res
        end
        curr == res ? res : 0
      end
    end

    def apply_operator(operator, left, right)
      case operator
      when 0
        left + right
      when 1
        left * right
      else
        "#{left}#{right}".to_i
      end
    end
  end
end
