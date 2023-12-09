# frozen_string_literal: true

# https://adventofcode.com/2023/day/9
module Year2023
  module Day09
    def process_input(str)
      str.split("\n").reject(&:empty?).map { |l| l.split.map(&:to_i) }
    end

    def problem1(input)
      input.sum do |nums|
        diffs = find_diffs(nums)
        (1...diffs.size).each do |i|
          diffs[-1 - i].push(diffs[-1 - i].last + diffs[-i].last)
        end
        diffs.first.last
      end
    end

    def problem2(input)
      input.sum do |nums|
        diffs = find_diffs(nums)
        (1...diffs.size).each do |i|
          diffs[-1 - i].unshift(diffs[-1 - i].first - diffs[-i].first)
        end
        diffs.first.first
      end
    end

    private

    def find_diffs(nums)
      diffs = [nums]
      diffs.push(diffs.last.each_cons(2).map { |a, b| b - a }) while diffs.last.any? { |n| !n.zero? }
      diffs
    end
  end
end
