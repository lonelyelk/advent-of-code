# frozen_string_literal: true

# https://adventofcode.com/2025/day/4
module Year2025
  module Day04
    def process_input(str)
      lines = str.split
      (0...lines.length).each_with_object({}) do |y, acc|
        lines[y].chars.each_with_index do |c, x|
          acc[[x, y]] = c
        end
      end
    end

    def problem1(input)
      input.count do |point, c|
        c == "@" && adjacent(point).count { |point| input[point] == "@" } < 4
      end
    end

    def problem2(input)
      count = 0
      loop do
        diff = 0
        input = input.each_with_object({}) do |(point, c), acc|
          if c == "." || count_adj_rolls(point, input) >= 4
            acc[point] = c
          else
            diff += 1 if c == "@"
            acc[point] = "."
          end
        end
        break if diff.zero?

        count += diff
      end
      count
    end

    private

    def adjacent(point)
      x, y = point
      [
        [x - 1, y - 1], [x, y - 1], [x + 1, y - 1],
        [x - 1, y], [x + 1, y],
        [x - 1, y + 1], [x, y + 1], [x + 1, y + 1],
      ]
    end

    def count_adj_rolls(point, input)
      adjacent(point).count { |pt| input[pt] == "@" }
    end
  end
end
