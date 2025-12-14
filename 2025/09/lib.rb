# frozen_string_literal: true

# https://adventofcode.com/2025/day/9
module Year2025
  module Day09
    def process_input(str)
      str.split.map { |line| line.split(",").map(&:to_i) }
    end

    def problem1(input)
      max = 0
      input.combination(2).each do |pair|
        area = calculate_area(pair)
        max = area if area > max
      end
      max
    end

    def problem2(input)
      horizontals, verticals = find_edges(input)
      max = 0
      input.combination(2).each do |pair|
        area = calculate_area(pair)
        next if area <= max
        next if inbound_horizontals(pair, horizontals)
        next if inbound_verticals(pair, verticals)

        max = area if area > max
      end
      max
    end

    private

    def calculate_area(pair)
      pair.inject(&:zip).map { |(a, b)| (a - b).abs + 1 }.inject(&:*)
    end

    def find_edges(input)
      horizontals = []
      verticals = []
      [*input, input.first].each_cons(2) do |(a, b)|
        if a.first == b.first
          verticals.push([a.first, Range.new(*[a.last, b.last].minmax)])
        else
          horizontals.push([a.last, Range.new(*[a.first, b.first].minmax)])
        end
      end
      [horizontals, verticals]
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    def inbound_horizontals(pair, horizontals)
      ymin, ymax = pair.map(&:last).minmax
      xmin, xmax = pair.map(&:first).minmax

      horizontals.any? do |(y, er)|
        ((ymin + 1)..(ymax - 1)).include?(y) &&
          ((er.include?(xmin) && er.end > xmin) ||
          (er.include?(xmax) && er.begin < xmax))
      end
    end

    def inbound_verticals(pair, verticals)
      ymin, ymax = pair.map(&:last).minmax
      xmin, xmax = pair.map(&:first).minmax

      verticals.any? do |(x, er)|
        ((xmin + 1)..(xmax - 1)).include?(x) &&
          ((er.include?(ymax) && er.begin < ymax) ||
            (er.include?(ymin) && er.end > ymin))
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity
  end
end
