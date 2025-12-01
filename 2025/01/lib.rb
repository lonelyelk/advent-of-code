# frozen_string_literal: true

# https://adventofcode.com/2025/day/1
module Year2025
  module Day01
    DIRECTION = {
      "L" => -1,
      "R" => 1,
    }.freeze

    def process_input(str)
      str.split
    end

    def problem1(input)
      curr = 50
      max = 100
      input.count do |move|
        dir = move[0]
        num = move[1..].to_i
        curr = (curr + num * DIRECTION[dir]) % max
        curr.zero?
      end
    end

    def problem2(input)
      curr = 50
      max = 100
      input.inject(0) do |acc, move|
        dir = move[0]
        num = move[1..].to_i
        num.times do
          curr = (curr + DIRECTION[dir]) % max
          acc += 1 if curr.zero?
        end
        acc
      end
    end
  end
end
