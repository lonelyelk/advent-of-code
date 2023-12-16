# frozen_string_literal: true

# https://adventofcode.com/2023/day/16
module Year2023
  module Day16
    def process_input(str)
      str.split("\n")
    end

    def problem1(input, init = [0i, 1i])
      ray = { init => true }
      e = energize({}, ray)
      until ray.empty?
        ray = ray.each_with_object({}) do |((pos, dir), _), nr|
          next_dirs(input, pos, dir).each { |d| propagate(input, e, nr, pos, d) }
        end
        e = energize(e, ray)
      end
      e.keys.map(&:first).uniq.size
    end

    def problem2(input)
      real_max = input.size - 1
      imag_max = input.first.size - 1
      hors = (0..real_max).flat_map do |r|
        [problem1(input, [Complex(r), 1i]), problem1(input, [Complex(r, imag_max), -1i])]
      end
      vers = (0..imag_max).flat_map do |i|
        [problem1(input, [Complex(0, i), 1]), problem1(input, [Complex(real_max, i), -1])]
      end
      [*hors, *vers].max
    end

    private

    def energize(energized, ray)
      ray.each_with_object(energized) do |(z, _), e|
        e[z] = true
      end
    end

    def propagate(input, energized, ray, pos, dir)
      next_pos = pos + dir
      return ray unless pos_within_input?(next_pos, input)
      return ray if energized[[next_pos, dir]]

      ray[[next_pos, dir]] = true
      ray
    end

    def pos_within_input?(pos, input)
      !pos.real.negative? && !pos.imag.negative? && pos.real < input.size && pos.imag < input.first.size
    end

    def next_dirs(input, pos, dir)
      case input[pos.real][pos.imag]
      when "."
        [dir]
      when "|"
        dir.imag.zero? ?  [dir] : [dir * 1i, dir * 1i**3]
      when "-"
        dir.real.zero? ? [dir] : [dir * 1i, dir * 1i**3]
      when "/"
        [dir.real.zero? ? dir * 1i : -dir * 1i]
      when "\\"
        [dir.imag.zero? ? dir * 1i : -dir * 1i]
      end
    end
  end
end
