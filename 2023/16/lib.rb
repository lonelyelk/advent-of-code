# frozen_string_literal: true

# https://adventofcode.com/2023/day/16
module Year2023
  module Day16
    def process_input(str)
      str.split("\n")
    end

    def problem1(input)
      ray = [[0i, 1i]]
      e = [] | ray
      until ray.empty?
        ray = ray.each_with_object([]) do |(pos, dir), nr|
          case input[pos.real][pos.imag]
          when "."
            nr.push([pos + dir, dir])
          when "|"
            if dir.imag.zero?
              nr.push([pos + dir, dir])
            else
              [dir * 1i, dir * 1i**3].each { |d| nr.push([pos + d, d]) } 
            end
          when "-"
            if dir.real.zero?
              nr.push([pos + dir, dir])
            else
              [dir * 1i, dir * 1i**3].each { |d| nr.push([pos + d, d]) } 
            end
          when "/"
            d = dir.real.zero? ? dir * 1i : -dir * 1i
            nr.push([pos + d, d])
          when "\\"
            d = dir.imag.zero? ? dir * 1i : -dir * 1i
            nr.push([pos + d, d])
          end
        end
        ray = ray.reject { |(pos, _)| pos.real.negative? || pos.imag.negative? || pos.real >= input.size || pos.imag >= input.first.size }
        ray -= e
        e |= ray
      end
      e.map(&:first).uniq.size
    end

    def problem2(input)
    end
  end
end
