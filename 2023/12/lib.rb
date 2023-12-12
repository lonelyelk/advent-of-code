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
        p ranges
        # solutions = possible_op_positions(ranges, total_op)
        solutions = ranges.each_with_index.inject([""]) do |sols, (range, index)|
          sols.each_with_object([]) do |sol, acc|
            next_sols = range.to_a.map do |num|
              sol + "." * num + (index < nums.size ? "#" * nums[index] : "")
            end
            p next_sols
            passing_sols = next_sols.select do |sol|
              sol.chars.each_with_index.all? { |c, i| map[i] == "?" || c == map[i] } &&
                sol.size <= map.size && sol.count("#") <= nums.sum
            end
            p passing_sols
            acc.push(*passing_sols)
          end
        end.select { |sol| sol.size == map.size }
        p [map, nums, solutions.size]
        p solutions
        solutions.count
      end
    end

    def problem2(input)
      unfolded_input = input.map do |map, nums|
        [Array.new(5, map) * "?", Array.new(5, nums).flatten]
      end
      problem1(unfolded_input)
    end

    private

    def possible_op_positions(ranges, total_op)
      ranges.inject([[]]) do |solutions, range|
        solutions.each_with_object([]) do |sol, acc|
          acc.push(*range.to_a.map { |num| [*sol, num] }.reject { |s| s.sum > total_op })
        end
      end.select { |sol| sol.sum == total_op }
    end
  end
end
