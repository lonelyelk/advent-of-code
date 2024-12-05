# frozen_string_literal: true

# https://adventofcode.com/2024/day/5
module Year2024
  module Day05
    def process_input(str)
      order, instructions = str.split("\n\n").map { |section| section.split("\n") }
      { order:, instructions: instructions.map { |line| line.split(",") } }
    end

    def problem1(input)
      correct = input[:instructions].select do |list|
        list == sort(list, input[:order])
      end
      correct.sum { |list| list[list.size / 2].to_i }
    end

    def problem2(input)
      corrected = input[:instructions].each_with_object([]) do |list, acc|
        sorted = sort(list, input[:order])
        acc.push(sorted) unless sorted == list
      end
      corrected.sum { |list| list[list.size / 2].to_i }
    end

    def sort(list, order)
      list.sort do |a, b|
        if order.include?("#{a}|#{b}")
          -1
        elsif order.include?("#{b}|#{a}")
          1
        else
          0
        end
      end
    end
  end
end
