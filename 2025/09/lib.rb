# frozen_string_literal: true

# https://adventofcode.com/2025/day/9
module Year2025
  module Day09
    def process_input(str)
      str.split.map { |line| line.split(",").map(&:to_i) }
    end

    def problem1(input)
      max = 0
      (0...(input.length - 1)).each do |i|
        ((i + 1)...input.length).each do |j|
          area = input[i].zip(input[j]).map { |(a, b)| (a - b).abs + 1 }.inject(&:*)
          max = area if area > max
        end
      end
      max
    end

    def problem2(input)
      edges = find_edges(input)
      max = 0
      (0...(input.length - 1)).each do |i|
        ((i + 1)...input.length).each do |j|
          area = input[i].zip(input[j]).map { |(a, b)| (a - b).abs + 1 }.inject(&:*)
          next if area <= max

          ymin, ymax = [input[i].last, input[j].last].minmax
          xmin, xmax = [input[i].first, input[j].first].minmax

          cross = edges[:horizontals].any? do |(y, er)|
            ((ymin + 1)..(ymax - 1)).include?(y) &&
              ((er.include?(xmin) && er.end > xmin) ||
              (er.include?(xmax) && er.begin < xmax))
          end
          next if cross

          cross = edges[:verticals].any? do |(x, er)|
            ((xmin + 1)..(xmax - 1)).include?(x) &&
              ((er.include?(ymax) && er.begin < ymax) ||
                (er.include?(ymin) && er.end > ymin))
          end
          next if cross

          max = area if area > max
        end
      end
      max
    end

    private

    def find_edges(input)
      [*input, input.first].each_cons(2).with_object({ verticals: [], horizontals: [] }) do |(a, b), acc|
        if a.first == b.first
          acc[:verticals].push([a.first, Range.new(*[a.last, b.last].minmax)])
        else
          acc[:horizontals].push([a.last, Range.new(*[a.first, b.first].minmax)])
        end
      end
    end
  end
end
