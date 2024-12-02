# frozen_string_literal: true

# https://adventofcode.com/2024/day/2
module Year2024
  module Day02
    def process_input(str)
      str.split("\n").map { |l| l.split.map(&:to_i) }
    end

    def problem1(input)
      input.count do |report|
        diffs = report.each_cons(2).map do |prev, nxt|
          nxt - prev
        end
        safe?(diffs)
      end
    end

    def problem2(input)
      input.count do |report|
        report.size.downto(0).any? do |i|
          diffs = (report[...i] + (report[(i + 1)..] || [])).each_cons(2).map do |prev, nxt|
            nxt - prev
          end
          safe?(diffs)
        end
      end
    end

    def safe?(report)
      sorted_report = report.sort
      (sorted_report.first.positive? && sorted_report.last <= 3) ||
        (sorted_report.first >= -3 && sorted_report.last.negative?)
    end
  end
end
