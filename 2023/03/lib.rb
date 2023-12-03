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
        num = ''
        line.chars.each_with_index do |char, col|
          if char.match?(/\d/)
            num += char
          else
            if !num.empty?
              is_part = (([0, row - 1].max)..([input.size - 1, row + 1].min)).any? do |r|
                (([0, col - num.size - 1].max)..col).any? { |c| !input[r][c].match?(/[0-9]|\./) }
              end
              sum += num.to_i if is_part
              num = ''
            end
          end
        end
        if !num.empty?
          is_part = (([0, row - 1].max)..([input.size - 1, row + 1].min)).any? do |r|
            (([0, line.size - num.size - 2].max)..(line.size - 1)).any? { |c| !input[r][c].match?(/[0-9]|\./) }
          end
          sum += num.to_i if is_part
        end
      end
      sum
    end

    def problem2(input)
      sum = 0
      input.each_with_index do |line, row|
        line.chars.each_with_index do |char, col|
          next unless char == "*"

          numbers = []
          (([0, row - 1].max)..([input.size - 1, row + 1].min)).each do |r|
            col_min = col == 0 ? col : input[r].rindex(/\D/, col - 1)
            col_max = col == line.size - 1 ? col : input[r].index(/\D/, col + 1)
            numbers += input[r][col_min..col_max].scan(/\d+/).map(&:to_i)
          end
          sum += numbers.inject(&:*) if numbers.size == 2
        end
      end
      sum
    end
  end
end
