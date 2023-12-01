# frozen_string_literal: true

# https://adventofcode.com/2023/day/1
module Year2023
  module Day01
    DIGITS = {
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9",
      "zero" => "0",
    }.freeze
    def process_input(str)
      str.split("\n").reject(&:empty?)
    end

    def problem1(input)
      input.sum do |line|
        digits = line.scan(/\d/)
        (digits.first + digits.last).to_i
      end
    end

    def problem2(input)
      input.sum do |line|
        digits = line.scan(/\d|#{DIGITS.keys.join("|")}/).map { |d| DIGITS[d] || d }
        (digits.first + digits.last).to_i
      end
    end
  end
end
