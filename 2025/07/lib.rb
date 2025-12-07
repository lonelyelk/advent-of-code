# frozen_string_literal: true

# https://adventofcode.com/2025/day/7
module Year2025
  module Day07
    def process_input(str)
      str.split
    end

    def problem1(input)
      splits = 0
      input.each_with_object({}) do |line, acc|
        line.chars.each_with_index do |c, i|
          if c == "S"
            acc[i] = true
          elsif c == "^" && acc[i]
            splits += 1
            acc[i] = false
            acc[i - 1] = acc[i + 1] = true
          end
        end
      end
      splits
    end

    def problem2(input)
      input.each_with_object(Hash.new { |h, k| h[k] = 0 }) do |line, acc|
        line.chars.each_with_index do |c, i|
          if c == "S"
            acc[i] += 1
          elsif c == "^" && acc[i].positive?
            acc[i - 1] += acc[i]
            acc[i + 1] += acc[i]
            acc[i] = 0
          end
        end
      end.values.sum
    end
  end
end
