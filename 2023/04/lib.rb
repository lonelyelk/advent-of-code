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
        won.positive? ? 2**(won - 1) : 0
      end
    end

    def problem2(input)
      cards = init_cards(input)
      input.each_with_index do |(winning, numbers), index|
        won = winning.count { |num| numbers.include?(num) }
        next if won.zero?

        (1..won).each do |inc|
          break unless cards[index + inc]

          cards[index + inc] += cards[index]
        end
      end
      cards.sum
    end

    private

    def init_cards(input)
      Array.new(input.size, 1)
    end
  end
end
