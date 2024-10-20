# frozen_string_literal: true

# https://adventofcode.com/2023/day/18
module Year2023
  module Day18
    DIRECTIONS = {
      "U" => [0, -1].freeze,
      "D" => [0, 1].freeze,
      "L" => [-1, 0].freeze,
      "R" => [1, 0].freeze,
      "3" => [0, -1].freeze, # U
      "1" => [0, 1].freeze,  # D
      "2" => [-1, 0].freeze, # L
      "0" => [1, 0].freeze,  # R
    }.freeze

    def process_input(str)
      str.split("\n").map do |line|
        md = line.match(/(\w) (\d+) \(#(.+)\)/)
        [md[1], md[2].to_i, md[3]]
      end
    end

    def problem1(input)
      trench = dig_trench1(input)
      seeds = { find_seed(trench) => true }
      inside = flood_fill(seeds, trench)
      trench.keys.size + inside.keys.size
    end

    # https://en.wikipedia.org/wiki/Shoelace_formula
    def problem2(input)
      trench, perim = dig_trench2(input)
      (trench.each_cons(2).sum do |(x1, y1), (x2, y2)|
        x1 * y2 - x2 * y1
      end / 2.0 + perim / 2.0).ceil
    end

    private

    def dig_trench1(input)
      pos = [0, 0]
      input.each_with_object({ pos => true }) do |(dir, num, _), trench|
        num.times do
          pos = DIRECTIONS[dir].zip(pos).map { |c, d| c + d }
          trench[pos] = true
        end
      end
    end

    def find_seed(trench)
      xmin, xmax, ymin, = trench.keys.transpose.map(&:minmax).flatten
      yseed = ymin + 1
      xseed = xmin.upto(xmax).detect do |x|
        !trench[[x, yseed]] && trench[[x, ymin]] && trench[[x - 1, yseed]] && trench[[x - 1, ymin]]
      end
      [xseed, yseed]
    end

    def flood(pos)
      DIRECTIONS.values.uniq.map { |dir| dir.zip(pos).map { |c, d| c + d } }
    end

    def flood_fill(seeds, trench)
      inside = {}
      until seeds.empty?
        seeds.each_key { |pt| inside[pt] = true }
        seeds = seeds.each_with_object({}) do |(pos, _), s|
          flood(pos).each do |pt|
            s[pt] = true unless trench[pt] || inside[pt]
          end
        end
      end
      inside
    end

    def dig_trench2(input)
      length = 1
      pos = [0, 0]
      trench = input.each_with_object([pos]) do |(_, _, instr), t|
        num = instr[..-2].to_i(16)
        length += num
        pos = DIRECTIONS[instr[-1]].map { |c| c * num }.zip(pos).map { |c, d| c + d }
        t.push(pos)
      end
      [trench, length]
    end
  end
end
