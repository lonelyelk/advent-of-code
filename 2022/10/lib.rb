# frozen_string_literal: true

# https://adventofcode.com/2022/day/10
module Year2022
  module Day10
    def process_input(str)
      str.split("\n").reject(&:empty?).map do |line|
        op, arg = line.split(" ", 2)
        arg.nil? ? [op] : [op, arg.to_i]
      end
    end

    def problem1(input)
      strength = []
      x = 1
      dx = 0
      c = 0
      input.each do |(op, arg)|
        x += dx
        dx = 0
        if op == "noop"
          c += 1
          strength.push(x * c) if c % 40 == 20
        else
          c += 2
          dx = arg
          strength.push(x * c) if c % 40 == 20
          strength.push(x * (c - 1)) if c % 40 == 21
        end
      end
      strength.inject(&:+)
    end

    def problem2(input)
      out = []
      x = 1
      dx = 0
      c = 0
      input.each do |(op, arg)|
        x += dx
        dx = 0
        if op == "noop"
          c += 1
          row = (c - 1) / 40
          col = (c - 1) % 40
          out[row] ||= []
          out[row][col] = (x - col).abs < 2 ? '#' : '.'
        else
          dx = arg
          2.times do
            c += 1
            row = (c - 1) / 40
            col = (c - 1) % 40
            out[row] ||= []
            out[row][col] = (x - col).abs < 2 ? '#' : '.'
          end
        end
      end
      out.map(&:join)
    end
  end
end
