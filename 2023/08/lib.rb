# frozen_string_literal: true

# https://adventofcode.com/2023/day/8
module Year2023
  module Day08
    def process_input(str)
      instructions, map = str.split("\n\n")
      response = { instructions: }
      map = map.split("\n").reject(&:empty?).each_with_object({}) do |line, m|
        md = line.match(/(.{3}) = \((.{3}), (.{3})\)/)
        m[md[1]] = [md[2], md[3]]
      end
      response[:map] = map
      response
    end

    def problem1(input)
      count = 0
      pos = "AAA"
      while pos != "ZZZ"
        instruction = input[:instructions][count % input[:instructions].size]
        pos = input[:map][pos]["LR" =~ /#{instruction}/]
        count += 1
      end
      count
    end

    def problem2(input)
      input[:map].keys.select { |k| k[-1] == "A" }.map do |start_pos|
        count = 0
        pos = start_pos
        while pos[-1] != "Z"
          instruction = input[:instructions][count % input[:instructions].size]
          pos = input[:map][pos]["LR" =~ /#{instruction}/]
          count += 1
        end
        count
      end.inject { |acc, num| acc.lcm(num) }
    end
  end
end
