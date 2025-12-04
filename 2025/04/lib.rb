# frozen_string_literal: true

# https://adventofcode.com/2025/day/4
module Year2025
  module Day04
    def process_input(str)
      lines = str.split
      (0...lines.length).each_with_object({}) do |y, acc|
        lines[y].chars.each_with_index do |c, x|
          acc[[x, y]] = true if c == "@"
        end
      end
    end

    def problem1(input)
      input.count do |point, _|
        count_adj_rolls(point, input) < 4
      end
    end

    def problem2(input)
      count = 0
      loop do
        size = input.size
        input = input.each_with_object({}) do |(point, _), acc|
          acc[point] = true if count_adj_rolls(point, input) >= 4
        end
        break if size == input.size

        count += size - input.size
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
      adjacent(point).count { |pt| input[pt] }
    end
  end
end
