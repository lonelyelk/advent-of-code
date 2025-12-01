# frozen_string_literal: true

# https://adventofcode.com/2025/day/1
module Year2025
  module Day01
    DIRECTION = {
      "L" => -1,
      "R" => 1,
    }.freeze
    START = 50
    MAX = 100

    def process_input(str)
      str.split
    end

    def problem1(input)
      curr = START
      input.count do |move|
        dir = move[0]
        num = move[1..].to_i
        curr = (curr + num * DIRECTION[dir]) % MAX
        curr.zero?
      end
    end

    def problem2(input)
      curr = START
      input.sum do |move|
        dir = move[0]
        num = move[1..].to_i
        step = DIRECTION[dir]

        count = count_zero_passes(curr, num, dir)
        curr = (curr + num * step) % MAX
        count
      end
    end

    private

    def count_zero_passes(curr, num, dir)
      distance_to_zero =
        if curr.zero?
          MAX
        else
          dir == "R" ? MAX - curr : curr
        end

      return 0 if num < distance_to_zero

      1 + (num - distance_to_zero) / MAX
    end
  end
end
