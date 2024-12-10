# frozen_string_literal: true

# https://adventofcode.com/2024/day/10
module Year2024
  module Day10
    STEPS = [-1i, 1 + 0i, 1i, -1 + 0i].freeze

    def process_input(str)
      str.split("\n").each_with_object({}).with_index do |(line, acc), y|
        line.chars.each_with_index do |c, x|
          acc[Complex(x, y)] = c.to_i
        end
      end
    end

    def problem1(input)
      heads = input.select { |_, v| v.zero? }
      trailheads = heads.each_with_object([]) { |(k, _), acc| acc.push([k]) }
      (1..9).each do |i|
        trailheads = trailheads.map do |points|
          points.filter_map do |point|
            STEPS.filter_map { |d| d + point if input[d + point] == i }
          end.flatten.uniq
        end
      end
      trailheads.sum(&:size)
    end

    def problem2(input)
      heads = input.select { |_, v| v.zero? }
      trailheads = heads.each_with_object([]) { |(k, _), acc| acc.push([k]) }
      (1..9).each do |i|
        trailheads = trailheads.map do |points|
          points.filter_map do |point|
            STEPS.filter_map { |d| d + point if input[d + point] == i }
          end.flatten
        end
      end
      trailheads.sum(&:size)
    end
  end
end
