# frozen_string_literal: true

# https://adventofcode.com/2022/day/4
module Year2022
  module Day04
    def process_input(str)
      lines = str.split("\n").reject(&:empty?)
      lines.map do |l|
        md = l.match(/(\d+)-(\d+),(\d+)-(\d+)/)
        [Range.new(md[1].to_i, md[2].to_i), Range.new(md[3].to_i, md[4].to_i)]
      end
    end

    def problem1(input)
      input.count do |(r1, r2)|
        r1.cover?(r2) || r2.cover?(r1)
      end
    end

    def problem2(input)
      input.count do |(r1, r2)|
        r1.cover?(r2.first) || r2.cover?(r1.first)
      end
    end
  end
end
