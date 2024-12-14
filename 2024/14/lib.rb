# frozen_string_literal: true

# https://adventofcode.com/2024/day/14
module Year2024
  module Day14
    def process_input(str)
      str.split("\n").map do |line|
        md = line.match(/p=(\d+),(\d+) v=(-?\d+),(-?\d+)/)
        md[1..].map(&:to_i).each_slice(2).to_a
      end
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def problem1(input, size = [101, 103], time = 100)
      midx, midy = size.map { |c| c / 2 }
      positions_in(input, size, time).each_with_object(Array.new(4, 0)) do |(x, y), acc|
        acc[0] += 1 if x < midx && y < midy
        acc[1] += 1 if x > midx && y < midy
        acc[2] += 1 if x > midx && y > midy
        acc[3] += 1 if x < midx && y > midy
      end.inject(&:*)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    def problem2(input, size = [101, 103])
      best_xt, best_yt = [0, 0]
      best_vx, best_vy = variances(input.map(&:first))
      (1..(size.max)).each do |i|
        positions = positions_in(input, size, i)
        vx, vy = variances(positions)
        best_vx, best_xt = [[vx, i], [best_vx, best_xt]].min_by(&:first)
        best_vy, best_yt = [[vy, i], [best_vy, best_yt]].min_by(&:first)
      end
      crt(best_xt, best_yt, *size)
    end

    def problem2_slow(input, size = [101, 103])
      (1...(size.inject(&:*))).min_by { |i| problem1(input, size, i) }
    end

    def positions_in(input, size, time)
      input.map do |(pos, vel)|
        pos.zip(vel).map.with_index { |(p, v), i| (p + v * time) % size[i] }
      end
    end

    def variances(positions)
      positions.transpose.map do |coords|
        mean = coords.sum.to_f / coords.size
        v = coords.inject(0.0) { |acc, coord| acc + (coord - mean)**2 }
        v / coords.size
      end
    end

    def crt(rem0, rem1, dim0, dim1)
      (1..).each do |t0|
        time = rem0 + dim0 * t0
        break time if time % dim1 == rem1
      end
    end
  end
end
