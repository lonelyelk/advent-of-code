# frozen_string_literal: true

# https://adventofcode.com/2023/day/4
module Year2023
  module Day04
    def process_input(str)
      str.split("\n").reject(&:empty?).map do |line|
        line.split(":")[1].split("|").map { |nums| nums.split.map(&:to_i) }
      end
    end

    def problem1(input)
      input.sum do |(winning, numbers)|
        won = winning.count { |num| numbers.include?(num) }
        won.positive? ? 2 ** (won - 1) : 0
      end
    end

    def problem2(input)
      cards = {}
      input.each_with_index do |(winning, numbers), index|
        cards[index] ||= 1
        won = winning.count { |num| numbers.include?(num) }
        next if won.zero?

        (1..won).each do |inc|
          break if index + inc >= input.size

          cards[index + inc] ||= 1
          cards[index + inc] += cards[index]
        end
      end
      cards.values.sum
    end
  end
end
