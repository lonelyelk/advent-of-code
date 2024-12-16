# frozen_string_literal: true

# https://adventofcode.com/2024/day/16
module Year2024
  module Day16
    def process_input(str)
      s = nil
      e = nil
      map = str.split("\n").map.with_index do |line, y|
        line.chars.map.with_index do |c, x|
          if c == "S"
            s = Complex(x, y)
            "."
          elsif c == "E"
            e = Complex(x, y)
            "."
          else
            c
          end
        end.join
      end
      { map:, s:, e: }
    end

    def problem1(input)
      map = input[:map].each_with_object({}).with_index do |(line, acc), y|
        line.chars.each_with_index do |c, x|
          next unless c == "."

          c = Complex(x, y)
          acc[c] = {}
        end
      end
      map[input[:s]] = {
        Complex(1, 0) => 0,
        Complex(0, 1) => 1000,
        Complex(0, -1) => 1000,
        Complex(-1, 0) => 2000,
      }
      edge = [input[:s]]
      until edge.empty?
        edge = edge.each_with_object([]) do |c, acc|
          map[c].each do |dir, pts|
            pos = c + dir
            next unless map[pos]

            better = false
            {
              dir => pts + 1,
              (dir * 1i) => pts + 1001,
              (-dir * 1i) => pts + 1001,
            }.each do |d, p|
              if map[pos][d].nil? || map[pos][d] > p
                better = true
                map[pos][d] = p
              end
            end
            acc.push(pos) if better
          end
        end
      end
      map[input[:e]].values.min
    end

    def problem2(input)
      map = input[:map].each_with_object({}).with_index do |(line, acc), y|
        line.chars.each_with_index do |c, x|
          next unless c == "."

          c = Complex(x, y)
          acc[c] = {}
        end
      end
      map[input[:s]] = {
        Complex(1, 0) => [0],
        Complex(0, 1) => [1000],
        Complex(0, -1) => [1000],
        Complex(-1, 0) => [2000],
      }
      edge = [input[:s]]
      until edge.empty?
        edge = edge.each_with_object([]) do |c, acc|
          map[c].each do |dir, pts_arr|
            pts, = pts_arr
            pos = c + dir
            next unless map[pos]

            better = false
            {
              dir => pts + 1,
              (dir * 1i) => pts + 1001,
              (-dir * 1i) => pts + 1001,
            }.each do |d, p|
              if map[pos][d].nil? || map[pos][d].first > p
                better = true
                map[pos][d] = [p, c]
              elsif map[pos][d].first == p
                map[pos][d].push(c)
              end
            end
            acc.push(pos) if better
          end
        end
      end
      e = map[input[:e]].values.min_by(&:first)
      edge = [[input[:e], *e]]
      points = [input[:e]]
      until edge.empty?
        edge = edge.each_with_object([]) do |pts_arr, acc|
          prev_c, pts, *coords = pts_arr
          coords.uniq.each do |c|
            points.push(c)
            n_pts_arr = map[c][prev_c - c]
            next unless n_pts_arr

            acc.push([c, *n_pts_arr]) if [1, 1001].include?(pts - n_pts_arr.first)
          end
        end.uniq
      end
      points.uniq.size
    end

    def map_char(map, coord)
      map[coord.imag][coord.real]
    end
  end
end
