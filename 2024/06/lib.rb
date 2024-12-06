# frozen_string_literal: true

# https://adventofcode.com/2024/day/6
module Year2024
  module Day06
    def process_input(str)
      map = str.split("\n")
      pos_y = map.index { |line| line.include?("^") }
      pos_x = map[pos_y].index("^")
      map[pos_y].sub!("^", ".")
      { map:, pos: Complex(pos_x, pos_y) }
    end

    def problem1(input)
      all_positions(input[:pos], input[:map]).keys.size
    end

    def problem2(input)
      positions = all_positions(input[:pos], input[:map])
      (positions.keys - [input[:pos]]).count do |obstacle_pos|
        input[:map][obstacle_pos.imag][obstacle_pos.real] = "#"
        positions = {}
        pos = [input[:pos], Complex(0, -1)]
        stuck = false
        loop do
          positions[pos] = true
          new_pos = [pos.sum, pos.last]
          break if out?(new_pos.first, input[:map])

          if positions[new_pos]
            stuck = true
            break
          end

          pos = if input[:map][new_pos.first.imag][new_pos.first.real] == "."
                  new_pos
                else
                  [pos.first, pos.last * 1i]
                end
        end
        input[:map][obstacle_pos.imag][obstacle_pos.real] = "."
        stuck
      end
    end

    def all_positions(pos, map, dir = Complex(0, -1))
      positions = {}
      loop do
        positions[pos] = true
        new_pos = pos + dir
        break if out?(new_pos, map)

        map[new_pos.imag][new_pos.real] == "." ? pos = new_pos : dir *= 1i
      end
      positions
    end

    def out?(pos, map)
      [pos.real, pos.imag].include?(-1) || pos.imag >= map.size || pos.real >= map.first.size
    end
  end
end
