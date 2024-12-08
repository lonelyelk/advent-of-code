# frozen_string_literal: true

# https://adventofcode.com/2024/day/8
module Year2024
  module Day08
    def process_input(str)
      str.split("\n")
    end

    def problem1(input)
      nodes = antennas(input).each_with_object([]) do |(_name, points), acc|
        each_pair(points) do |v1, v2, d|
          acc.push(v2 + d, v1 - d)
        end
      end
      nodes.uniq.count do |point|
        inside?(point, input)
      end
    end

    # rubocop:disable Metrics/AbcSize
    def problem2(input)
      nodes = antennas(input).each_with_object([]) do |(_name, points), acc|
        each_pair(points, normalize: true) do |v1, _, d|
          forward = (0..).lazy.map { |i| v1 + d * i }.take_while { |point| inside?(point, input) }
          backward = (1..).lazy.map { |i| v1 - d * i }.take_while { |point| inside?(point, input) }
          acc.push(*forward)
          acc.push(*backward)
        end
      end
      nodes.uniq.count
    end
    # rubocop:enable Metrics/AbcSize

    def antennas(input)
      input.each_with_object({}).with_index do |(line, acc), i|
        line.chars.each_with_index do |c, j|
          next if c == "."

          acc[c] ||= []
          acc[c].push(Vector[j, i])
        end
      end
    end

    def each_pair(points, normalize: false)
      return if points.size < 2

      points.combination(2) do |(v1, v2)|
        d = v2 - v1
        d /= d[0].gcd(d[1]) if normalize
        yield(v1, v2, d)
      end
    end

    def inside?(point, input)
      point.all? { |coord| coord >= 0 } && point[0] < input.size && point[1] < input.first.size
    end
  end
end
