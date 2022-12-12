# frozen_string_literal: true

# https://adventofcode.com/2022/day/12
module Year2022
  module Day12
    ELEVATION = (?a..?z).to_a

    def process_input(str)
      str.split("\n").reject(&:empty?).each_with_object({ field: [] }) do |line, state|
        if (start = line.index(?S))
          state[:start] = [start, state[:field].size]
        end
        if (finish = line.index(?E))
          state[:end] = [finish, state[:field].size]
        end
        state[:field].push(line.tr("SE", "az").chars)
      end
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def problem1(input)
      paths = init_paths(input, input[:start])
      stepped = true
      while stepped
        stepped = false
        from_each_point_in_each_direction(paths) do |x, y, xx, yy|
          next if too_steep?(input, xx, yy, x, y)

          paths[yy][xx] = paths[y][x] + 1
          stepped = true
        end
      end
      paths[input[:end][1]][input[:end][0]]
    end

    def problem2(input)
      paths = init_paths(input, input[:end])
      path = 500
      stepped = true
      while stepped
        stepped = false
        from_each_point_in_each_direction(paths) do |x, y, xx, yy|
          next if too_steep?(input, x, y, xx, yy)

          paths[yy][xx] = paths[y][x] + 1
          path = paths[yy][xx] if input[:field][yy][xx] == ?a && paths[yy][xx] < path
          stepped = true
        end
      end
      path
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    private

    def init_paths(input, zero)
      paths = Array.new(input[:field].size) { Array.new(input[:field].first.size) }
      paths[zero[1]][zero[0]] = 0
      paths
    end

    def each_direction(x_pos, y_pos, x_range, y_range)
      [x_pos - 1, x_pos + 1].select { |c| x_range.include?(c) }.each do |x|
        yield(x, y_pos)
      end
      [y_pos - 1, y_pos + 1].select { |c| y_range.include?(c) }.each do |y|
        yield(x_pos, y)
      end
    end

    def from_each_point_in_each_direction(paths)
      paths.size.times do |y|
        paths[y].size.times do |x|
          next if paths[y][x].nil?

          each_direction(x, y, 0...paths.first.size, 0...paths.size) do |xx, yy|
            yield(x, y, xx, yy) unless already_passed?(paths, xx, yy, x, y)
          end
        end
      end
    end

    def too_steep?(input, x_high, y_high, x_low, y_low)
      ELEVATION.index(input[:field][y_high][x_high]) - ELEVATION.index(input[:field][y_low][x_low]) > 1
    end

    def already_passed?(paths, x_next, y_next, x_curr, y_curr)
      paths[y_next][x_next] && paths[y_next][x_next] <= paths[y_curr][x_curr] + 1
    end
  end
end
