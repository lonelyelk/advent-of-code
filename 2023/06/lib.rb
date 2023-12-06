# frozen_string_literal: true

# https://adventofcode.com/2023/day/6
module Year2023
  module Day06
    def process_input(str)
      str.split("\n")[..1].map { |l| l.split(":")[1].split.map(&:to_i) }.inject(&:zip)
    end

    def process_input2(str)
      str.split("\n")[..1].map { |l| l.split(":")[1].split.join.to_i }
    end

    def problem1(input)
      input.map do |(time, record)|
        count_ways_to_win(time, record)
      end.inject(&:*)
    end

    def problem2(input)
      count_ways_to_win(*input)
    end

    def count_ways_to_win(time, record)
      disc = Math.sqrt(time**2 - 4 * record)
      x1 = (time - disc) / 2
      x2 = (time + disc) / 2
      x2.ceil - x1.floor - 1
    end
  end
end
