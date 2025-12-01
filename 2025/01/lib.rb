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
        num.times.count do
          curr = (curr + DIRECTION[dir]) % MAX
          curr.zero?
        end
      end
    end
  end
end
