# frozen_string_literal: true

# https://adventofcode.com/2025/day/3
module Year2025
  module Day03
    def process_input(str)
      str.split
    end

    def problem1(input)
      input.sum do |line|
        first_digit = line.chars[...-1].max
        second_digit = line[(line.index(first_digit) + 1)..].chars.max
        (first_digit + second_digit).to_i
      end
    end

    def problem2(input)
      input.sum do |line|
        first = 0
        digits = -12.upto(-1).map do |last|
          digit = line[first..last].chars.max
          first += line[first..].index(digit) + 1
          digit
        end
        digits.join.to_i
      end
    end
  end
end
