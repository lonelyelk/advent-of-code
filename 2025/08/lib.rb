# frozen_string_literal: true

# https://adventofcode.com/2025/day/8
module Year2025
  module Day08
    def process_input(str)
      str.split.map { |line| line.split(",").map(&:to_i) }
    end

    def problem1(input, conn = 1000)
      circuits = []
      distances = input.each_with_index.with_object({}) do |(point, i), acc|
        ((i + 1)...input.length).each do |j|
          acc[distance_2(point, input[j])] = [point, input[j]]
        end
      end
      distances.keys.sort[...conn].each do |dist|
        point1, point2 = distances[dist]
        already = circuits.select { |c| c[point1] || c[point2] }
        if already.empty?
          circuits.push({ point1 => true, point2 => true })
        elsif already.size == 1
          already.first[point1] = already.first[point2] = true
        else
          circuits.delete(already.first)
          already.first.each_key { |pt| already.last[pt] = true }
        end
      end
      count_circuits = []
      circuits.sort { |a, b| b.size <=> a.size }.each do |circuit|
        count_circuits.push(circuit) unless count_circuits.include?(circuit)
        break if count_circuits.size == 3
      end
      # p count_circuits
      count_circuits.map(&:size).inject(&:*)
    end

    def problem2(input)
      circuits = []
      distances = input.each_with_index.with_object({}) do |(point, i), acc|
        ((i + 1)...input.length).each do |j|
          acc[distance_2(point, input[j])] = [point, input[j]]
        end
      end
      distances.keys.sort[0..].each do |dist|
        point1, point2 = distances[dist]
        already = circuits.select { |c| c[point1] || c[point2] }
        if already.empty?
          circuits.push({ point1 => true, point2 => true })
        elsif already.size == 1
          already.first[point1] = already.first[point2] = true
        else
          circuits.delete(already.first)
          already.first.each_key { |pt| already.last[pt] = true }
        end
        break point1.first * point2.first if circuits.size == 1 && circuits.first.size == input.size
      end
    end

    private

    def distance_2(point1, point2)
      point1.zip(point2).map { |arr| arr.inject(&:-) }.map { |n| n * n }.sum
    end
  end
end
