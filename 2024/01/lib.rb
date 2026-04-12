# frozen_string_literal: true

# https://adventofcode.com/2024/day/1
module Year2024
  module Day01
    def process_input(str)
      str.split("\n").map { |l| l.split(/\s+/).map(&:to_i) }.transpose
    end

    def problem1(input)
      input.map(&:sort).inject(&:zip).map { |nums| nums.inject(&:-).abs }.sum
    end

    def problem2(input)
      right_count = input[1].tally
      input[0].sum do |num|
        num * (right_count[num] || 0)
      end
    end
  end
end
