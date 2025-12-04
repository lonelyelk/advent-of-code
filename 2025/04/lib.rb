# frozen_string_literal: true

# https://adventofcode.com/2025/day/4
module Year2025
  module Day04
    ADJACENT = [
      [- 1, - 1], [0, - 1], [1, - 1],
      [- 1, 0], [1, 0],
      [- 1, 1], [0, 1], [1, 1],
    ].freeze

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
      total = input.size
      loop do
        size = input.size
        input.each_key do |point|
          input.delete(point) if count_adj_rolls(point, input) < 4
        end
        break if size == input.size
      end
      total - input.size
    end

    private

    def count_adj_rolls(point, input)
      ADJACENT.count { |pt| input[[point[0] + pt[0], point[1] + pt[1]]] }
    end
  end
end
