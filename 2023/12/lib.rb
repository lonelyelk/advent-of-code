# frozen_string_literal: true

# https://adventofcode.com/2023/day/12
module Year2023
  module Day12
    def process_input(str)
      str.split("\n").reject(&:empty?).map do |line|
        map, nums = line.split
        [map, nums.split(",").map(&:to_i)]
      end
    end

    def problem1(input)
      input.sum do |map, nums|
        total_op = map.size - nums.sum
        spaces = nums.size - 1
        diff = [total_op - spaces, map.scan(/[.?]+/).map(&:size).max].min
        ranges = [0..diff, *Array.new(spaces, 1..(1 + diff)), 0..diff]
        @cache = {}
        count_solutions(map, nums, ranges)
      end
    end

    def problem2(input)
      unfolded_input = input.map do |map, nums|
        [Array.new(5, map) * "?", Array.new(5, nums).flatten]
      end
      problem1(unfolded_input)
    end

    private

    def count_solutions(map, nums, ranges)
      key = [map, nums]
      return @cache[key] if @cache[key]

      passing_sols = next_possible_solutions(map, nums, ranges)
      return @cache[key] = passing_sols.count { |sol| sol.size == map.size } if nums.empty?

      @cache[key] = passing_sols.sum do |sol|
        count_solutions(map[sol.size..], nums[1..], ranges[1..])
      end
    end

    def next_possible_solutions(map, nums, ranges)
      next_sols = ranges.first.to_a.map do |n|
        "." * n + (nums.empty? ? "" : "#" * nums.first)
      end
      next_sols.select do |sol|
        sol.chars.each_with_index.all? { |c, i| map[i] == c || map[i] == "?" }
      end
    end
  end
end
