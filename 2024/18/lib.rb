# frozen_string_literal: true

# https://adventofcode.com/2024/day/18
module Year2024
  module Day18
    def process_input(str)
      str.split("\n").map { |line| line.split(",").map(&:to_i) }
    end

    def problem1(input, max = [70, 70], num_bytes = 1024)
      set = input[...num_bytes].each_with_object({}) { |c, acc| acc[c] = true }
      edge = [[0, 0]]
      map = { [0, 0] => 0 }
      until edge.empty?
        edge = edge.each_with_object([]) do |c, acc|
          possible_steps(c, max).each do |nc|
            next if set[nc] || (map[nc] && map[nc] < map[c] + 1)

            map[nc] = map[c] + 1
            acc.push(nc)
          end
        end.uniq
      end
      map[max]
    end

    def problem2(input, max = [70, 70], start = 1024)
      start.upto(input.size) do |i|
        p "#{i}/#{input.size}"
        break input[i - 1].join(",") if problem1(input, max, i).nil?
      end
    end

    def possible_steps(coord, max)
      x, y = coord
      maxx, maxy = max
      [[1, 0], [0, 1], [-1, 0], [0, -1]].each_with_object([]) do |(x1, y1), acc|
        acc.push([x + x1, y + y1]) if x + x1 >= 0 && y + y1 >= 0 && x + x1 <= maxx && y + y1 <= maxy
      end
    end
  end
end
