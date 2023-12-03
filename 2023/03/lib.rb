# frozen_string_literal: true

# https://adventofcode.com/2023/day/3
module Year2023
  module Day03
    def process_input(str)
      str.split("\n").reject(&:empty?)
    end

    def problem1(input)
      sum = 0
      input.each_with_index do |line, row|
        num = ""
        (line.size + 1).times do |col|
          if line[col]&.match?(/\d/)
            num += line[col]
            next
          end
          next if num.empty?

          sum += num.to_i if part?(input, num, row, col)
          num = ""
        end
      end
      sum
    end

    def problem2(input)
      sum = 0
      input.each_with_index do |line, row|
        line.chars.each_with_index do |char, col|
          next unless char == "*"

          numbers = gear_parts(input, row, [0, col - 1].max, [line.size - 1, col + 1].min)
          sum += numbers.inject(&:*) if numbers.size == 2
        end
      end
      sum
    end

    private

    def part?(input, num_str, row, col)
      col_min = [0, col - num_str.size - 1].max
      (([0, row - 1].max)..([input.size - 1, row + 1].min)).any? { |r| input[r][col_min..col].match?(/[^\d.]/) }
    end

    def gear_parts(input, row, col_before, col_after)
      (([0, row - 1].max)..([input.size - 1, row + 1].min)).each_with_object([]) do |r, numbers|
        col_min = input[r].rindex(/\D/, col_before)
        col_max = input[r].index(/\D/, col_after)
        numbers.push(*input[r][col_min..col_max].scan(/\d+/).map(&:to_i))
      end
    end
  end
end
