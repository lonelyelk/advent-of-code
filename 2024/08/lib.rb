# frozen_string_literal: true

# https://adventofcode.com/2024/day/8
module Year2024
  module Day08
    def process_input(str)
      str.split("\n")
    end

    def problem1(input)
      nodes = antennas(input).each_with_object([]) do |(_name, points), acc|
        next if points.size < 2

        points[...-1].each_with_index do |(x1, y1), i|
          points[(i + 1)..].each do |(x2, y2)|
            dx, dy = [x2 - x1, y2 - y1]
            acc.push([x2 + dx, y2 + dy], [x1 - dx, y1 - dy])
          end
        end
      end
      nodes.uniq.count do |point|
        inside?(point, input)
      end
    end

    def problem2(input)
      nodes = antennas(input).each_with_object([]) do |(_name, points), acc|
        next if points.size < 2

        points[...-1].each_with_index do |(x1, y1), i|
          points[(i + 1)..].each do |(x2, y2)|
            dx, dy = [x2 - x1, y2 - y1]
            gcd = dx.gcd(dy)
            dx /= gcd
            dy /= gcd
            point = [x1, y1]
            while inside?(point, input)
              acc.push(point)
              point = [point[0] + dx, point[1] + dy]
            end
            point = [x1, y1]
            while inside?(point, input)
              acc.push(point)
              point = [point[0] - dx, point[1] - dy]
            end
          end
        end
      end
      nodes.uniq.count
    end

    def antennas(input)
      input.each_with_object({}).with_index do |(line, acc), i|
        line.chars.each_with_index do |c, j|
          next if c == "."

          acc[c] ||= []
          acc[c].push([j, i])
        end
      end
    end

    def inside?(point, input)
      point.all? { |coord| coord >= 0 } && point[0] < input.size && point[1] < input.first.size
    end
  end
end
