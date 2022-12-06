# frozen_string_literal: true

# https://adventofcode.com/2022/day/6
module Year2022
  module Day06
    def process_input(str)
      str.chomp
    end

    def problem1(input)
      (3...input.size).each do |i|
        return i + 1 if input[(i - 3)..i].chars.uniq.size == 4
      end
    end

    def problem2(input)
      (13...input.size).each do |i|
        return i + 1 if input[(i - 13)..i].chars.uniq.size == 14
      end
    end
  end
end
