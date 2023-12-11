# frozen_string_literal: true

# https://adventofcode.com/2023/day/11
module Year2023
  module Day11
    def process_input(str)
      galaxies = []
      str.split("\n").reject(&:empty?).each_with_index do |line, y|
        line.chars.each_with_index do |c, x|
          galaxies.push([x, y]) if c == "#"
        end
      end
      galaxies
    end

    def problem1(input)
      expand_xs, expand_ys = expanded_coordinates(input)
      expanded_input = input.map do |(x, y)|
        [x + expand_xs.count { |xx| xx < x }, y + expand_ys.count { |yy| yy < y }]
      end
      sum_distances(expanded_input)
    end

    def problem2(input, factor = 1_000_000)
      expand_xs, expand_ys = expanded_coordinates(input)
      expanded_input = input.map do |(x, y)|
        [x + (factor - 1) * expand_xs.count { |xx| xx < x }, y + (factor - 1) * expand_ys.count { |yy| yy < y }]
      end
      sum_distances(expanded_input)
    end

    private

    def expanded_coordinates(input)
      xs, ys = input.transpose
      [Range.new(*xs.minmax).to_a - xs, Range.new(*ys.minmax).to_a - ys]
    end

    def sum_distances(input)
      input.combination(2).sum do |((x1, y1), (x2, y2))|
        (x1 - x2).abs + (y1 - y2).abs
      end
    end
  end
end
