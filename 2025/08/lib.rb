# frozen_string_literal: true

# https://adventofcode.com/2025/day/8
module Year2025
  module Day08
    def process_input(str)
      str.split.map { |line| line.split(",").map(&:to_i) }
    end

    def problem1(input, conn = 1000)
      circuits = pairs_sorted_by_distance(input).take(conn).inject([]) do |acc, (point1, point2)|
        join_points(point1, point2, acc)
      end
      circuits.sort { |a, b| b.size <=> a.size }.take(3).map(&:size).inject(&:*)
    end

    def problem2(input)
      circuits = []
      pairs_sorted_by_distance(input).each do |(point1, point2)|
        circuits = join_points(point1, point2, circuits)
        break point1.first * point2.first if circuits.size == 1 && circuits.first.size == input.size
      end
    end

    private

    def distance2(point1, point2)
      point1.zip(point2).map { |arr| arr.inject(&:-) }.map { |n| n * n }.sum
    end

    def pairs_sorted_by_distance(input)
      distances = input.each_with_index.with_object({}) do |(point, i), acc|
        ((i + 1)...input.length).each do |j|
          next if i == j

          acc[distance2(point, input[j])] = [point, input[j]]
        end
      end
      distances.sort_by { |key, _| key }.map(&:last)
    end

    def join_points(point1, point2, circuits)
      case (already = circuits.select { |c| c[point1] || c[point2] }).size
      when 0
        circuits.push({ point1 => true, point2 => true })
      when 1
        already.first[point1] = already.first[point2] = true
      else
        circuits.delete(already.first).each_key { |pt| already.last[pt] = true }
      end
      circuits
    end
  end
end
