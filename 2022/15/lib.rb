# frozen_string_literal: true

# https://adventofcode.com/2022/day/15
module Year2022
  module Day15
    def process_input(str)
      str.scan(/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/).map do |(sx, sy, bx, by)|
        {
          sensor: [sx.to_i, sy.to_i],
          beacon: [bx.to_i, by.to_i],
          distance: (bx.to_i - sx.to_i).abs + (by.to_i - sy.to_i).abs,
        }
      end
    end

    def problem1(input, target_y = 2_000_000)
      excluded_xs = input.each_with_object([]) do |line, excluded|
        dx = line[:distance] - (line[:sensor][1] - target_y).abs
        next if dx <= 0

        r = (line[:sensor][0] - dx)..(line[:sensor][0] + dx)
        excluded.push(r)
      end
      occupied_xs = input.each_with_object({}) do |line, acc|
        acc[line[:beacon][0]] = true if line[:beacon][1] == target_y
      end
      merged = merge_ranges(excluded_xs)
      merged.map(&:size).inject(&:+) - occupied_xs.keys.count { |x| merged.any? { |r| r.include?(x) } }
    end

    def problem2(input, max_coord = 4_000_000)
      (0..max_coord).each do |target_y|
        excluded_xs = input.each_with_object([]) do |line, excluded|
          dx = line[:distance] - (line[:sensor][1] - target_y).abs
          next if dx <= 0

          r = ([line[:sensor][0] - dx, 0].max)..([line[:sensor][0] + dx, max_coord].min)
          excluded.push(r) if r.size.positive?
        end
        mins, maxs = excluded_xs.map(&:minmax).transpose.map(&:uniq)
        mins.each do |min|
          xs = maxs.select { |max| min - max == 2 }
          xs.each do |x|
            return (x + 1) * 4_000_000 + target_y if excluded_xs.all? { |r| !r.cover?(x + 1) }
          end
        end
      end
    end

    private

    def merge_ranges(ranges)
      ranges.sort { |a, b| a.min <=> b.min }.each_with_object([]) do |r, acc|
        if acc.last&.cover?(r.min)
          acc[-1] = acc.last.min..r.max unless acc.last.cover?(r)
        else
          acc.push(r)
        end
      end
    end
  end
end
