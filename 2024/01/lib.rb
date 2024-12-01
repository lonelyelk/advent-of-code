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
      right_count = input[1].each_with_object(Hash.new(0)) do |num, cnt|
        cnt[num] += 1
      end
      input[0].sum do |num|
        num * right_count[num]
      end
    end
  end
end
