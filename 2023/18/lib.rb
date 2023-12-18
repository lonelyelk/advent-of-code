# frozen_string_literal: true

# https://adventofcode.com/2023/day/18
module Year2023
  module Day18
    def process_input(str)
      str.split("\n").map do |line|
        md = line.match(/(\w) (\d+) \(#(.+)\)/)
        [md[1], md[2].to_i, md[3]]
      end
    end

    def problem1(input)
      pos = [0, 0]
      trench = { pos => true }
      input.each do |(dir, num, _)|
        num.times do
          pos =
            case dir
            when "U"
              [pos.first, pos.last - 1]
            when "D"
              [pos.first, pos.last + 1]
            when "L"
              [pos.first - 1, pos.last]
            when "R"
              [pos.first + 1, pos.last]
            end
          trench[pos] = true
        end
      end
      xmin, xmax, ymin, ymax = trench.keys.transpose.map(&:minmax).flatten
      yseed = ymin + 1
      xseed = xmin.upto(xmax).detect { |x| !trench[[x, yseed]] && trench[[x, ymin]] && trench[[x - 1, yseed]] && trench [[x - 1, ymin]] }
      seeds = { [xseed, yseed] => true }
      inside = {}
      until seeds.empty?
        seeds.each { |pt, _| inside[pt] = true }
        seeds = seeds.each_with_object({}) do |((x, y), _), s|
          [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].each do |pt|
            s[pt] = true unless trench[pt] || inside[pt]
          end
        end
      end
      trench.keys.size + inside.keys.size
    end

    # https://en.wikipedia.org/wiki/Shoelace_formula
    def problem2(input)
      perim = 1
      pos = [0, 0]
      trench = input.each_with_object([pos]) do |(_, _, instr), t|
        num = instr[..-2].to_i(16)
        x, y = pos
        perim += num
        pos =
          case instr[-1]
          when "3" # U
            [x, y - num]
          when "1" # D
            [x, y + num]
          when "2" # L
            [x - num, y]
          when "0" # R
            [x + num, y]
          end
        t.push(pos)
      end
      (trench.each_cons(2).sum do |(x1, y1), (x2, y2)|
        x1 * y2 - x2 * y1
      end / 2.0 + perim / 2.0).ceil
    end
  end
end
