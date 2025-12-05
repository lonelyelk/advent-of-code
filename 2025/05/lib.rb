# frozen_string_literal: true

# https://adventofcode.com/2025/day/5
module Year2025
  module Day05
    def process_input(str)
      fresh, inventory = str.split("\n\n")
      fresh = fresh.split.map do |range|
        start, finish = range.split("-")
        (start.to_i..finish.to_i)
      end
      inventory = inventory.split.map(&:to_i)
      { fresh:, inventory: }
    end

    def problem1(input)
      input[:inventory].count do |id|
        input[:fresh].any? { |r| r.include?(id) }
      end
    end

    def problem2(input)
      fresh = input[:fresh].each_with_object([]) do |range, acc|
        overlaps = acc.select { |r| r.overlap?(range) }
        unless overlaps.empty?
          overlaps.each { |r| acc.delete_at(acc.index(r)) }
          range = overlaps.inject(range) do |frange, r|
            if frange.include?(r.begin)
              if frange.include?(r.end)
                frange
              else
                (frange.begin..r.end)
              end
            elsif frange.include?(r.end)
              (r.begin..frange.end)
            else
              r
            end
          end
        end
        acc.push(range)
      end
      fresh.sum(&:size)
    end
  end
end
