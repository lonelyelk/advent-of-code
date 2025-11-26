# frozen_string_literal: true

# https://adventofcode.com/2023/day/24
module Year2023
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  module Day24
    def process_input(str)
      str.split("\n").map { |line| line.split("@").map { |v| v.split(",").map(&:to_i) } }
    end

    def problem1(input, range = (200_000_000_000_000..400_000_000_000_000))
      (0...(input.size - 1)).sum do |l1|
        ((l1 + 1)...(input.size)).count do |l2|
          c1, v1 = input[l1]
          c2, v2 = input[l2]
          denom = (v1[0] * v2[1] - v1[1] * v2[0])
          if denom.zero?
            false
          else
            t = Rational((c1[1] - c2[1]) * v2[0] - (c1[0] - c2[0]) * v2[1], denom)
            u = Rational((c1[1] - c2[1]) * v1[0] - (c1[0] - c2[0]) * v1[1], denom)
            pc1 = [c1[0] + t * v1[0], c1[1] + t * v1[1]]
            range.include?(pc1[0]) && range.include?(pc1[1]) &&
              u.positive? && t.positive?
          end
        end
      end
    end

    def problem2(input)
      c0, v0 = input[0]
      a = []
      b = []
      (1..3).each do |i|
        ci, vi = input[i]
        a.push([v0[1] - vi[1], vi[0] - v0[0], 0, ci[1] - c0[1], c0[0] - ci[0], 0])
        a.push([v0[2] - vi[2], 0, vi[0] - v0[0], ci[2] - c0[2], 0, c0[0] - ci[0]])
        b.push(c0[0] * v0[1] - c0[1] * v0[0] - ci[0] * vi[1] + ci[1] * vi[0])
        b.push(c0[0] * v0[2] - c0[2] * v0[0] - ci[0] * vi[2] + ci[2] * vi[0])
      end
      (Matrix[*a].inverse * Matrix.columns([b])).to_a.flatten[..2].inject(&:+).to_i
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
end
