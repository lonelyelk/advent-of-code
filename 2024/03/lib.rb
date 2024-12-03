# frozen_string_literal: true

# https://adventofcode.com/2024/day/3
module Year2024
  module Day03
    def process_input(str)
      str
    end

    def problem1(input)
      input.scan(/mul\((\d+),(\d+)\)/).sum do |(a, b)|
        a.to_i * b.to_i
      end
    end

    def problem2(input)
      input.split("do()").sum do |instr_do|
        problem1(instr_do.split("don't()", 2).first)
      end
    end
  end
end
