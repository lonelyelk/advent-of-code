# frozen_string_literal: true

# https://adventofcode.com/2024/day/10
module Year2024
  module Day10
    STEPS = 4.times.map { |i| 1i * 1i**i }.freeze

    def process_input(str)
      str.split("\n").each_with_object({}).with_index do |(line, acc), y|
        line.chars.each_with_index do |c, x|
          acc[Complex(x, y)] = c.to_i
        end
      end
    end

    def problem1(input)
      heads = input.select { |_, v| v.zero? }
      trails = heads.each_with_object([]) { |(k, _), acc| acc.push([k]) }
      (1..9).each do |i|
        trails = step_to(i, trails, input)
      end
      trails.sum { |points| points.uniq.size }
    end

    def problem2(input)
      heads = input.select { |_, v| v.zero? }
      trails = heads.each_with_object([]) { |(k, _), acc| acc.push([k]) }
      (1..9).each do |i|
        trails = step_to(i, trails, input)
      end
      trails.sum(&:size)
    end

    def step_to(height, trails, map)
      trails.map do |points|
        points.flat_map do |point|
          STEPS.filter_map { |d| d + point if map[d + point] == height }
        end
      end
    end
  end
end
