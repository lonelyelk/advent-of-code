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

    # rubocop:disable Metrics/AbcSize
    def problem1(input, target_y = 2_000_000)
      excluded_xs = input.each_with_object([]) do |line, excluded|
        dx = line[:distance] - (line[:sensor][1] - target_y).abs
        next if dx <= 0

        excluded.push((line[:sensor][0] - dx)..(line[:sensor][0] + dx))
      end
      merged = merge_ranges(excluded_xs)
      merged.map(&:size).inject(&:+) -
        occupied__by_beacon_xs(input, target_y).count { |x| merged.any? { |r| r.include?(x) } }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    def problem2(input, max_coord = 4_000_000)
      key_ys = input.each_with_object(input.map { |l| l[:sensor][1] }) do |line, ys|
        ys.push(line[:sensor][1] - line[:distance], line[:sensor][1] + line[:distance])
      end
      key_ys = key_ys.sort.uniq
      target_y = 0
      while target_y <= max_coord
        excluded_xs = input.each_with_object([]) do |line, excluded|
          dx = line[:distance] - (line[:sensor][1] - target_y).abs
          next if dx <= 0

          r = ([line[:sensor][0] - dx, 0].max)..([line[:sensor][0] + dx, max_coord].min)
          excluded.push(r) if r.size.positive?
        end
        mins, maxs = excluded_xs.map(&:minmax).transpose.map(&:uniq)
        gaps = mins.each_with_object([]) do |min, acc|
          maxs.each do |max|
            acc.push([min - max, max + 1]) if min > max && (min - max).even?
          end
        end
        candidates = gaps.select { |(diff, _)| diff == 2 }
        unless candidates.empty?
          merged = merge_ranges(excluded_xs)
          candidates.each do |(_, x)|
            return x * 4_000_000 + target_y if merged.all? { |r| !r.cover?(x) }
          end
        end
        min_gap = gaps.min_by(&:first)
        if min_gap.nil?
          target_y += 1
        else
          diff = [(min_gap.first - 2) / 2, 1].max
          target_y = [target_y + diff, key_ys.detect { |x| x > target_y }].min
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

    private

    def occupied__by_beacon_xs(input, target_y)
      occupied_xs = input.each_with_object({}) do |line, acc|
        acc[line[:beacon][0]] = true if line[:beacon][1] == target_y
      end
      occupied_xs.keys
    end

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
