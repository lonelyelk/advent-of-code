# frozen_string_literal: true

# https://adventofcode.com/2024/day/20
module Year2024
  module Day20
    def process_input(str)
      res = {}
      res[:map] = str.split("\n").map.with_index do |line, y|
        line.chars.map.with_index do |c, x|
          res[c.downcase.to_sym] = [x, y] if %w[S E].include?(c)
          c.sub(/[SE]/, ".")
        end.join
      end
      res
    end

    # Part 2 was the more generic solution so it's a refactoring
    def problem1(input, max_gain = 100)
      problem2(input, max_gain, 2)
    end

    def problem2(input, max_gain = 100, max_cheat = 20)
      point = input[:s]
      points = { point => (steps = 0) }
      until points[input[:e]]
        movements(point, input[:map]).each do |(x, y)|
          point = [x, y] if input[:map][y][x] == "." && !points[[x, y]]
        end
        steps += 1
        points[point] = steps
      end
      count_cheats(points, max_gain, max_cheat)
    end

    def movements(point, map)
      x, y = point
      [[0, 1], [0, -1], [1, 0], [-1, 0]].filter_map do |(x1, y1)|
        [x + x1, y + y1] if (1...(map.size - 1)).include?(y + y1) && (1...(map.first.size - 1)).include?(x + x1)
      end
    end

    # rubocop:disable Metrics/AbcSize
    def count_cheats(points, max_gain, max_cheat)
      points.sum do |(x, y), val|
        (-max_cheat..max_cheat).sum do |y1|
          dx = max_cheat - y1.abs
          (-dx..dx).count do |x1|
            point = [x + x1, y + y1]
            points[point] && points[point] - val >= max_gain + x1.abs + y1.abs
          end
        end
      end
    end
    # rubocop:enable Metrics/AbcSize
  end
end
