# frozen_string_literal: true

# https://adventofcode.com/2024/day/6
module Year2024
  module Day06
    def process_input(str)
      map = str.split("\n")
      pos_y = map.index { |line| line.include?("^") }
      pos_x = map[pos_y].index("^")
      map[pos_y].sub!("^", ".")
      { map:, pos: [Complex(pos_x, pos_y), -1i] }
    end

    def problem1(input)
      possible_coordinates(input).size
    end

    def problem2(input)
      (possible_coordinates(input) - [input[:pos].first]).count do |obstacle_pos|
        map = input[:map].map(&:dup)
        map[obstacle_pos.imag][obstacle_pos.real] = "#"
        res = catch(:stuck) do
          all_positions(input[:pos], map)
        end
        !res
      end
    end

    def possible_coordinates(input)
      all_positions(input[:pos], input[:map]).keys.map(&:first).uniq
    end

    def all_positions(pos, map)
      positions = {}
      loop do
        positions[pos] = true
        new_pos = [pos.sum, pos.last]
        break if out?(new_pos.first, map)

        throw :stuck if positions[new_pos]

        pos = free?(new_pos.first, map) ? new_pos : [pos.first, pos.last * 1i]
      end
      positions
    end

    def free?(pos, map)
      map[pos.imag][pos.real] == "."
    end

    def out?(pos, map)
      [pos.real, pos.imag].include?(-1) || pos.imag >= map.size || pos.real >= map.first.size
    end
  end
end
