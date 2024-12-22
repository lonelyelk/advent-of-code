# frozen_string_literal: true

# https://adventofcode.com/2024/day/18
module Year2024
  module Day18
    def process_input(str)
      str.split("\n").map { |line| line.split(",").map(&:to_i) }
    end

    def problem1(input, max = [70, 70], num_bytes = 1024)
      walk_map(input, max, num_bytes)[max]
    end

    def problem2(input, max = [70, 70], start = 1024)
      path = nil
      start.upto(input.size) do |i|
        next unless path.nil? || path[input[i - 1]]

        map = walk_map(input, max, i)
        break input[i - 1].join(",") unless map[max]

        path = walk_back(map, max)
      end
    end

    def bytes_fall(input, num_bytes)
      input[...num_bytes].each_with_object({}) { |c, acc| acc[c] = true }
    end

    def possible_steps(coord, max)
      x, y = coord
      maxx, maxy = max
      [[1, 0], [0, 1], [-1, 0], [0, -1]].each_with_object([]) do |(x1, y1), acc|
        acc.push([x + x1, y + y1]) if x + x1 >= 0 && y + y1 >= 0 && x + x1 <= maxx && y + y1 <= maxy
      end
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def walk_map(input, max, num_bytes)
      set = bytes_fall(input, num_bytes)
      edge = { [0, 0] => true }
      map = { [0, 0] => 0 }
      until edge.empty?
        edge = edge.each_with_object({}) do |(c, _), acc|
          possible_steps(c, max).each do |nc|
            next if set[nc] || (map[nc] && map[nc] < map[c] + 1)

            map[nc] = map[c] + 1
            acc[nc] = true
          end
        end
      end
      map
    end
    # rubocop:enable Metrics/AbcSize

    def walk_back(map, max)
      path = { max => map[max] }
      edge = { max => true }
      steps = map[max]
      until path[[0, 0]]
        steps -= 1
        edge = edge.each_with_object({}) do |(c, _), acc|
          possible_steps(c, max).each do |nc|
            if map[nc] == steps
              path[nc] = steps
              acc[nc] = true
            end
          end
        end
      end
      path
    end
    # rubocop:enable Metrics/MethodLength
  end
end
