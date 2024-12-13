# frozen_string_literal: true

# https://adventofcode.com/2024/day/13
module Year2024
  module Day13
    def process_input(str)
      str.split("\n\n").map do |data|
        m1, m2, v = data.scan(/[^:]: X=?(\S+?), Y=?(\S+)/).map { |arr| Matrix[arr.map(&:to_i)] }
        [
          m1.vstack(m2).transpose,
          v.transpose,
        ]
      end
    end

    def problem1(input)
      input.sum do |(m, v)|
        press_a, press_b = (m.inverse * v).column(0).to_a
        if press_a.denominator == 1 && press_b.denominator == 1
          3 * press_a.numerator + press_b.numerator
        else
          0
        end
      end
    end

    def problem2(input)
      input.sum do |(m, v)|
        correct_v = Matrix.column_vector([10_000_000_000_000, 10_000_000_000_000]) + v
        press_a, press_b = (m.inverse * correct_v).column(0).to_a
        if press_a.denominator == 1 && press_b.denominator == 1
          3 * press_a.numerator + press_b.numerator
        else
          0
        end
      end
    end
  end
end
