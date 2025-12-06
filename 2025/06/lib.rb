# frozen_string_literal: true

# https://adventofcode.com/2025/day/6
module Year2025
  module Day06
    def process_input(str)
      str.split("\n")
    end

    def problem1(input)
      input.map { |l| l.strip.split(/\s+/) }.transpose.sum do |problem|
        problem[...-1].map(&:to_i).inject(&problem.last.to_sym)
      end
    end

    def problem2(input)
      input.map(&:chars)
           .transpose.reverse
           .each_with_object({ sum: 0, curr: [] }) do |arr, acc|
        next if arr.all? { |c| c == " " }

        acc[:curr].push(arr[...-1].join.to_i)
        next unless arr.last != " "

        acc[:sum] += acc[:curr].inject(&arr.last.strip.to_sym)
        acc[:curr] = []
      end[:sum]
    end
  end
end
