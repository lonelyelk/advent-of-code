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

    def problem1(input, size = [101, 103], time = 100)
      positions = positions_in(input, size, time)
      midx, midy = size.map { |c| c / 2 }
      positions.each_with_object(Array.new(4, 0)) do |(x, y), acc|
        acc[0] += 1 if x < midx && y < midy
        acc[1] += 1 if x > midx && y < midy
        acc[2] += 1 if x > midx && y > midy
        acc[3] += 1 if x < midx && y > midy
      end.inject(&:*)
    end

    def problem2(input, size = [101, 103])
      best_xt, best_yt = [0, 0]
      best_vx, best_vy = variances(input.map(&:first))
      size.max.times do |i|
        positions = positions_in(input, size, i + 1)
        vx, vy = variances(positions)
        if vx < best_vx
          best_vx = vx
          best_xt = i + 1
        end
        if vy < best_vy
          best_vy = vy
          best_yt = i + 1
        end
      end
      (1..).each do |xt|
        time = best_xt + xt * size[0]
        break time if time % size[1] == best_yt
      end
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
  end
end
