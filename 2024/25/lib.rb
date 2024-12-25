# frozen_string_literal: true

# https://adventofcode.com/2024/day/25
module Year2024
  module Day25
    def process_input(str)
      schematics = str.split("\n\n")
      schematics.each_with_object({ locks: [], keys: [] }) do |schematic, acc|
        lines = schematic.split("\n")
        name = lines.first == "#####" ? :locks : :keys
        acc[name].push(lines.map(&:chars).transpose.map { |carr| carr.count("#") - 1 })
      end
    end

    def problem1(input)
      input[:locks].sum do |lock|
        input[:keys].count do |key|
          lock.zip(key).map(&:sum).all? { |s| s <= 5 }
        end
      end
    end

    def problem2(input); end
  end
end
