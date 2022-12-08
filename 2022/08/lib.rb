# frozen_string_literal: true

# https://adventofcode.com/2022/day/8
module Year2022
  module Day08
    def process_input(str)
      str.split("\n").reject(&:empty?).map { |l| l.chars.map(&:to_i) }
    end

    def problem1(input)
      visible = {}
      (1...(input.size - 1)).each do |y|
        (1...(input[y].size - 1)).each do |x|
          if input[y][...x].max < input[y][x] || input[y][(x + 1)..].max < input[y][x]
            visible["#{x},#{y}"] = true
          end
        end
      end
      input = input.transpose
      (1...(input.size - 1)).each do |y|
        (1...(input[y].size - 1)).each do |x|
          if input[y][...x].max < input[y][x] || input[y][(x + 1)..].max < input[y][x]
            visible["#{y},#{x}"] = true
          end
        end
      end
      visible.keys.length + input.size * 2 + (input.first.size - 2) * 2
    end

    def problem2(input)
      scores = {}
      (1...(input.size - 1)).each do |y|
        (1...(input[y].size - 1)).each do |x|
          dir1 = (x - (input[y][...x].rindex { |e| e >= input[y][x] } || 0))
          dir2 = ((input[y][(x + 1)..].index { |e| e >= input[y][x] } || input[y].size - x - 2) + 1)
          scores["#{x},#{y}"] = dir1 * dir2
        end
      end
      input = input.transpose
      (1...(input.size - 1)).each do |y|
        (1...(input[y].size - 1)).each do |x|
          dir1 = (x - (input[y][...x].rindex { |e| e >= input[y][x] } || 0))
          dir2 = ((input[y][(x + 1)..].index { |e| e >= input[y][x] } || input[y].size - x - 2) + 1)
          scores["#{y},#{x}"] *= dir1 * dir2
        end
      end
      scores.values.max
    end
  end
end
