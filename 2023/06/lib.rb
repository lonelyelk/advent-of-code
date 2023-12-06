# frozen_string_literal: true

# https://adventofcode.com/2023/day/6
module Year2023
  module Day06
    def process_input(str)
      str.split("\n")[..1].map { |l| l.split(":")[1].split.map(&:to_i) }.inject(&:zip)
    end

    def problem1(input)
      input.map do |(time, record)|
        x1 = (time - Math.sqrt((time)**2 - 4 * record)) / 2
        x2 = (time + Math.sqrt((time)**2 - 4 * record)) / 2
        x1 = x1 == x1.ceil ? x1.to_i + 1 : x1.ceil
        x2 = x2 == x2.floor ? x2.to_i - 1 : x2.floor
        x2 + 1 - x1
      end.inject(&:*)
    end

    def problem2(input)
      problem1([input.inject(["", ""]) { |acc, (t, r)| [acc[0].to_s + t.to_s, acc[1].to_s + r.to_s].map(&:to_i) }])
    end
  end
end
