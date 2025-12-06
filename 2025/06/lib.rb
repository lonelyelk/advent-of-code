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
      process_input2(input).each_with_object({ sum: 0, curr: [] }) do |arr, acc|
        operator = arr.pop
        acc[:curr].push(arr.join.to_i)
        next if operator == " "

        acc[:sum] += acc[:curr].inject(&operator.to_sym)
        acc[:curr] = []
      end[:sum]
    end

    private

    def process_input2(input)
      input.map(&:chars).transpose.reverse.reject { |a| a.all? { |c| c == " " } }
    end
  end
end
