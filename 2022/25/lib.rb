# frozen_string_literal: true

# https://adventofcode.com/2022/day/25
module Year2022
  module Day25
    DIGIT_MAP = {
      ?2 => 2,
      ?1 => 1,
      ?0 => 0,
      ?- => -1,
      ?= => -2,
    }.freeze

    def process_input(str)
      str.split("\n").reject(&:empty?)
    end

    def problem1(input)
      input.inject(0) do |acc, num|
        n = num.chars.reverse.each_with_index.inject(0) { |n_acc, (c, i)| n_acc + DIGIT_MAP[c] * (5**i) }
        acc + n
      end
    end

    def problem2(input)
      out = ""
      tmp = []
      while input >= 5
        input, rem = input.divmod(5)
        if rem > 2
          input += 1
          rem -= 5
        end
        tmp.push(rem)
      end
      if input > 2
        tmp.push(input - 5)
        tmp.push(1)
      else
        tmp.push(input)
      end
      tmp.reverse.map { |n| DIGIT_MAP.key(n) }.join
    end
  end
end
