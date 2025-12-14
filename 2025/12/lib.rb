# frozen_string_literal: true

# https://adventofcode.com/2025/day/12
module Year2025
  module Day12
    def process_input(str)
      str.split("\n\n").each_with_object({ presents: [], spaces: [] }) do |block, acc|
        if block =~ /^\d+:/
          id, *present = block.split("\n")
          acc[:presents][id.sub(":", "").to_i] = present
        else
          acc[:spaces] = block.split("\n").map do |line|
            md = line.match(/(\d+)x(\d+): (.+)/)
            {
              width: md[1].to_i,
              length: md[2].to_i,
              presents: md[3].split.map(&:to_i),
            }
          end
        end
      end
    end

    def problem1(input)
      input[:spaces].count do |space|
        if (space[:width] / 3) * (space[:length] / 3) >= space[:presents].sum
          true
        elsif space[:width] * space[:length] < space[:presents].each_with_index.sum do |num, i|
          num * input[:presents][i].sum do |line|
            line.count("#")
          end
        end
          false
        else
          raise "Can't do this"
        end
      end
    end
  end
end
