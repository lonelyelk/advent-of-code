# frozen_string_literal: true

# https://adventofcode.com/2024/day/15
module Year2024
  # rubocop:disable Metrics/ModuleLength
  module Day15
    def process_input(str)
      map_input, ops_input = str.split("\n\n")
      start = nil
      map = map_input.split("\n").each_with_object({}).with_index do |(line, acc), y|
        line.chars.each_with_index do |c, x|
          acc[[x, y]] = c if "#O".include?(c)
          start = [x, y] if c == "@"
        end
      end
      [start, map, ops_input.split("\n").join.chars]
    end

    # rubocop:disable Metrics/MethodLength
    def problem1(input)
      pos, map, ops = input.map(&:dup)
      ops.each do |op|
        n_pos = next_pos(pos, op)
        next if map[n_pos] == "#"

        if map[n_pos]
          to_move = workload(n_pos, map, op)
          to_take = next_pos(to_move.last, op)
          next if map[to_take]

          map[to_take] = map.delete(to_move.first)
        end
        pos = n_pos
      end
      gps(map, "O")
    end
    # rubocop:enable Metrics/MethodLength

    def direction(dir, mult = 1)
      case dir
      when "^"
        [0, -mult]
      when ">"
        [mult, 0]
      when "v"
        [0, mult]
      else
        [-mult, 0]
      end
    end

    def next_pos(start, dir, mult = 1)
      start.zip(direction(dir, mult)).map(&:sum)
    end

    def workload(start, map, dir)
      work_body = (0..).lazy.map { |mult| next_pos(start, dir, mult) }
      work_body.take_while { |coord| map[coord] == "O" }.to_a
    end

    def gps(map, char)
      map.keys.select { |k| map[k] == char }.sum { |(x, y)| x + 100 * y }
    end

    def display(map, pos)
      puts
      x_range, y_range = map.keys.transpose.map(&:minmax)
      y_range.first.upto(y_range.last).each do |y|
        x_range.first.upto(x_range.last).each do |x|
          print(map[[x, y]] || (pos == [x, y] ? "@" : "."))
        end
        puts
      end
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def problem2(input)
      pos, map, ops = scale_up(input)
      ops.each do |op|
        n_pos = next_pos(pos, op)
        next if map[n_pos] == "#"

        unless map[n_pos]
          pos = n_pos
          next
        end

        catch("#") do
          wl = {}
          next_wl = { pos => nil }
          wl.merge!(next_wl = next_workload(next_wl.keys, map, op)) until next_wl.empty?
          wl.each_key { |coord| map.delete(coord) }
          wl.each { |coord, val| map[next_pos(coord, op)] = val }
          pos = n_pos
        end
      end
      gps(map, "[")
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

    def scale_up(input)
      start, map, ops = input
      scaled_map = map.each_with_object({}) do |((x, y), val), acc|
        acc[[x * 2, y]] = val == "O" ? "[" : val
        acc[[x * 2 + 1, y]] = val == "O" ? "]" : val
      end
      x, y = start
      [[x * 2, y], scaled_map, ops]
    end

    # rubocop:disable Metrics/MethodLength
    def next_workload(prev_wl, map, dir)
      prev_wl.each_with_object({}) do |coord, acc|
        x, y = next_pos(coord, dir)
        case map[[x, y]]
        when "["
          acc[[x, y]] = "["
          acc[[x + 1, y]] = "]" unless coord == [x + 1, y]
        when "]"
          acc[[x, y]] = "]"
          acc[[x - 1, y]] = "[" unless coord == [x - 1, y]
        when "#"
          throw "#"
        end
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
  # rubocop:enable Metrics/ModuleLength
end
