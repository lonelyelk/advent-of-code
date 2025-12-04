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
      input.count do |(x, y), c|
        c == "@" && adjacent(x, y).count { |point| input[point] == "@" } < 4
      end
    end

    def problem2(input)
      count = 0
      next_input = input
      loop do
        next_count = count
        next_input = next_input.each_with_object({}) do |((x, y), c), acc|
          if c == "."
            acc[[x, y]] = c
          else
            adj_rolls = adjacent(x, y).count { |point| next_input[point] == "@" }
            if adj_rolls < 4
              next_count += 1
              acc[[x, y]] = "."
            else
              acc[[x, y]] = "@"
            end
          end
        end
        break if next_count == count

        count = next_count
      end
      count
    end

    private

    def adjacent(x, y)
      [
        [x - 1, y - 1],
        [x, y - 1],
        [x + 1, y - 1],
        [x - 1, y],
        [x + 1, y],
        [x - 1, y + 1],
        [x, y + 1],
        [x + 1, y + 1],
      ]
    end
  end
end
