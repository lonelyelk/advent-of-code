# frozen_string_literal: true

# https://adventofcode.com/2025/day/7
module Year2025
  module Day07
    def process_input(str)
      str.split
    end

    def problem1(input)
      splits = 0
      input.each_with_object(init_problem1(input)) do |line, acc|
        line.chars.each_with_index do |c, i|
          next unless c == "^" && acc[i]

          splits += 1
          acc[i] = false
          acc[i - 1] = acc[i + 1] = true
        end
      end
      splits
    end

    # rubocop:disable Metrics/AbcSize
    def problem2(input)
      beams = input.each_with_object(init_problem2(input)) do |line, acc|
        line.chars.each_with_index do |c, i|
          next unless c == "^" && acc[i].positive?

          acc[i - 1] += acc[i]
          acc[i + 1] += acc[i]
          acc[i] = 0
        end
      end
      beams.values.sum
    end
    # rubocop:enable Metrics/AbcSize

    private

    def init_problem1(input)
      h = {}
      h[input.first.index("S")] = true
      h
    end

    def init_problem2(input)
      h = Hash.new { |h, k| h[k] = 0 }
      h[input.first.index("S")] = 1
      h
    end
  end
end
