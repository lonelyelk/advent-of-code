# frozen_string_literal: true

# https://adventofcode.com/2024/day/16
module Year2024
  module Day16
    def process_input(str)
      res = {}
      map = str.split("\n").map.with_index do |line, y|
        line.chars.map.with_index do |c, x|
          res[:s] = Complex(x, y) if c == "S"
          res[:e] = Complex(x, y) if c == "E"
          c.sub(/[SE]/, ".")
        end.join
      end
      res.merge(map:)
    end

    def problem1(input)
      map = map_points(input)
      map[input[:e]].values.map(&:first).min
    end

    # rubocop:disable Metrics/AbcSize
    def problem2(input)
      map = map_points(input)
      path = { input[:e] => map[input[:e]].values.min_by(&:first) }
      until path[input[:s]]
        path.merge!(path.each_with_object({}) do |(prev_c, (_, *coords)), acc|
          coords.each { |c| acc[c] = map[c][prev_c - c] }
        end)
      end
      path.size
    end
    # rubocop:enable Metrics/AbcSize

    def transform_to_map(input)
      input[:map].each_with_object({}).with_index do |(line, acc), y|
        line.chars.each_with_index do |c, x|
          next unless c == "."

          c = Complex(x, y)
          acc[c] = c == input[:s] ? { 1 + 0i => [0], 1i => [1000], -1i => [1000] } : {}
        end
      end
    end

    def dir_options(dir, pts)
      {
        dir => pts + 1,
        (1i * dir) => pts + 1001,
        (-1i * dir) => pts + 1001,
      }
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    def map_points(input)
      map = transform_to_map(input)
      edge = [input[:s]]
      until edge.empty?
        edge = edge.each_with_object([]) do |c, acc|
          map[c].each do |dir, (pts, *_)|
            pos = c + dir
            next unless map[pos]

            better = false
            opts = pos == input[:e] ? { dir => pts + 1 } : dir_options(dir, pts)
            opts.each do |d, p|
              if map[pos][d].nil? || map[pos][d].first > p
                better = true
                map[pos][d] = [p, c]
              elsif map[pos][d].first == p
                map[pos][d] |= [c]
              end
            end
            acc.push(pos) if better && pos != input[:e]
          end
        end
      end
      map
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  end
end
