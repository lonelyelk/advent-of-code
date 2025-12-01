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
      input.sum do |move|
        dir = move[0]
        num = move[1..].to_i
        num.times.count do
          curr = (curr + DIRECTION[dir]) % max
          curr.zero?
        end
      end
    end
  end
end
