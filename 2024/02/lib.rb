# frozen_string_literal: true

# https://adventofcode.com/2024/day/2
module Year2024
  module Day02
    def process_input(str)
      str.split("\n").map { |l| l.split.map(&:to_i) }
    end

    def problem1(input)
      input.count do |report|
        diffs = []
        report[..-2].each_with_index do |num, i|
          diffs.push(report[i + 1] - num)
        end
        safe?(diffs.sort)
      end
    end

    def problem2(input)
      input.count do |report|
        diffs = []
        report[..-2].each_with_index do |num, i|
          diffs.push(report[i + 1] - num)
        end
        safe?(diffs.sort) ||
          report.size.times.any? do |i|
            diffs = []
            r = report.dup
            r.delete_at(i)
            r[..-2].each_with_index do |n, j|
              diffs.push(r[j + 1] - n)
            end
            safe?(diffs.sort)
          end
      end
    end

    def safe?(sorted_report)
      (sorted_report.first.positive? && sorted_report.last <= 3) ||
        (sorted_report.first >= -3 && sorted_report.last.negative?)
    end
  end
end
