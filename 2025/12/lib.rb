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
          acc[:spaces] = parse_spaces(block)
        end
      end
    end

    def problem1(input)
      input[:spaces].count do |space|
        if (space[:width] / 3) * (space[:length] / 3) >= space[:presents].sum
          true
        elsif !theoretically_can_fit?(space, input[:presents])
          false
        else
          raise "Can't do this"
        end
      end
    end

    private

    def parse_spaces(block)
      block.split("\n").map do |line|
        md = line.match(/(\d+)x(\d+): (.+)/)
        {
          width: md[1].to_i,
          length: md[2].to_i,
          presents: md[3].split.map(&:to_i),
        }
      end
    end

    def theoretically_can_fit?(space, presents)
      min_space = space[:presents].each_with_index.sum do |num, i|
        num * presents[i].sum do |line|
          line.count("#")
        end
      end
      space[:width] * space[:length] >= min_space
    end
  end
end
