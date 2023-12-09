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
        (diffs.size - 2).downto(0).inject(0) do |acc, i|
          diffs[i].push(diffs[i].last + acc).last
        end
      end
    end

    def problem2(input)
      input.sum do |nums|
        diffs = find_diffs(nums)
        (diffs.size - 2).downto(0).inject(0) do |acc, i|
          diffs[i].unshift(diffs[i].first - acc).first
        end
      end
    end

    private

    def find_diffs(nums)
      diffs = [nums]
      diffs.push(diffs.last.each_cons(2).map { |a, b| b - a }) until diffs.last.all?(&:zero?)
      diffs
    end
  end
end
