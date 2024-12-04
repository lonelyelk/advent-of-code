# frozen_string_literal: true

# https://adventofcode.com/2024/day/4
module Year2024
  module Day04
    def process_input(str)
      str.split("\n")
    end

    def problem1(input)
      hor = count_xmas_and_backward(input)
      ver = count_xmas_and_backward(input.map(&:chars).transpose.map(&:join))
      diag_right = count_xmas_and_backward(diagonals(input))
      diag_left = count_xmas_and_backward(diagonals(input.map(&:reverse)))
      hor + ver + diag_right + diag_left
    end

    def problem2(input)
      1.upto(input.size - 2).sum do |i|
        1.upto(input[i].size - 2).sum do |j|
          x_mas?(input[i - 1, 3].map { |l| l[j - 1, 3] }) ? 1 : 0
        end
      end
    end

    def count_xmas_and_backward(lines)
      count_and_backward(lines, "XMAS")
    end

    def count_and_backward(lines, expr)
      right = lines.sum do |line|
        line.scan(expr).size
      end
      left = lines.map(&:reverse).sum do |line|
        line.scan(expr).size
      end
      left + right
    end

    def diagonals(lines)
      (lines.size + lines.first.size).times.map do |i|
        0.upto(i).map do |j|
          (lines[j] || [])[i - j] || ""
        end
      end.map(&:join)
    end

    def x_mas?(sub_lines)
      count_and_backward(diagonals(sub_lines), "MAS") == 1 &&
        count_and_backward(diagonals(sub_lines.map(&:reverse)), "MAS") == 1
    end
  end
end
