# frozen_string_literal: true

# https://adventofcode.com/2024/day/20
module Year2024
  module Day20
    def process_input(str)
      res = {}
      res[:map] = str.split("\n").map.with_index do |line, y|
        line.chars.map.with_index do |c, x|
          if %w[S E].include?(c)
            res[c.downcase.to_sym] = [x, y]
            "."
          else
            c
          end
        end.join
      end
      res
    end

    def problem1(input, max = 100)
      cheats = Hash.new { |h, k| h[k] = [] }
      point = input[:s]
      steps = 0
      points = {}
      until points[input[:e]]
        points[point] = steps
        moves = movements(point, input[:map])
        moves.each do |(x, y)|
          if input[:map][y][x] == "."
            point = [x, y] unless points[[x, y]]
          else
            cheats[[x, y]].push(steps)
          end
        end
        steps += 1
      end
      cheats.values.filter_map do |arr|
        diff = -2 - arr.minmax.inject(&:-)
        diff if diff >= max
      end.count
    end

    def problem2(input, max = 100)
      point = input[:s]
      steps = 0
      points = { point => steps }
      until points[input[:e]]
        moves = movements(point, input[:map])
        moves.each do |(x, y)|
          point = [x, y] if input[:map][y][x] == "." && !points[[x, y]]
        end
        steps += 1
        points[point] = steps
      end
      points.sum do |(x, y), val|
        (-20..20).sum do |y1|
          diry = y1.zero? ? 0 : y1 / y1.abs
          dx = 20 - y1.abs
          (-dx..dx).count do |x1|
            dirx = x1.zero? ? 0 : x1 / x1.abs
            if points[[x + x1, y + y1]] && points[[x + x1, y + y1]] - val == 72 + x1 + y1
              p [
                [x, y], val, [x + x1, y + y1], points[[x + x1, y + y1]],
                input[:map][y][x + dirx] == "#" || input[:map][y + diry][x] == "#",
                input[:map][y + y1][x + x1 - dirx] == "#" || input[:map][y + y1 - diry][x + x1] == "#",
              ]
            end
            points[[x + x1, y + y1]] &&
              points[[x + x1, y + y1]] - val == max + x1 + y1 &&
              (input[:map][y][x + dirx] == "#" || input[:map][y + diry][x] == "#") &&
              (input[:map][y + y1][x + x1 - dirx] == "#" || input[:map][y + y1 - diry][x + x1] == "#")
          end
        end
      end
    end

    def movements(point, map)
      x, y = point
      [[0, 1], [0, -1], [1, 0], [-1, 0]].filter_map do |(x1, y1)|
        [x + x1, y + y1] if (1...(map.size - 1)).include?(y + y1) && (1...(map.first.size - 1)).include?(x + x1)
      end
    end
  end
end
