# frozen_string_literal: true

# https://adventofcode.com/2023/day/24
module Year2023
  module Day24
    def process_input(str)
      str.split("\n").map { |line| line.split("@").map { |v| v.split(",").map(&:to_i) } }
    end

    def problem1(input, range = (200000000000000..400000000000000))
      (0...(input.size - 1)).sum do |l1|
        ((l1 + 1)...(input.size)).count do |l2|
          c1, v1 = input[l1]
          c2, v2 = input[l2]
          denom = (v1[0] * v2[1] - v1[1] * v2[0])
          if denom.zero?
            false
          else
            t = Rational(((c1[1] - c2[1]) * v2[0] - (c1[0] - c2[0]) * v2[1]), denom)
            u = Rational(((c1[1] - c2[1]) * v1[0] - (c1[0] - c2[0]) * v1[1]), denom)
            pc1 = [c1[0] + t * v1[0], c1[1] + t * v1[1]]
            # p [pc1, pc2, input[l1], input[l2], range.include?(pc1[0]), range.include?(pc1[1]), u.positive?, t.positive?]
              range.include?(pc1[0]) && range.include?(pc1[1]) &&
              u.positive? && t.positive?
          end
        end
      end
    end

    def problem2(input)
      sx = [nil, nil]
      svx = [nil, nil]
      ranges = [[[sx, svx]], [[sx, svx]], [[sx, svx]]]
      count = 0
      input.each do |(c, v)|
        count += 1
        3.times do |index|
          cc = c[index]
          vv = v[index]
          ranges[index] = ranges[index].each_with_object([]) do |(cr, vcr), r|
            # sx < x && svx > vx
            ncr = set_range_max(cr, cc - 1)
            nvcr = set_range_min(vcr, vv + 1)
            r.push([ncr, nvcr]) if ncr && nvcr

            # sx > x && svx < vx
            ncr = set_range_min(cr, cc + 1)
            nvcr = set_range_max(vcr, vv - 1)
            r.push([ncr, nvcr]) if ncr && nvcr
          end
        end
        puts "#{count} / #{input.size} : #{ranges.map(&:size)}"
      end
      p ranges
    end

    private

    def set_range_max(range, max)
      if range[1] && range[1] <= max
        range
      elsif range[0].nil? || range[0] < max
        [range[0], max]
      end
    end

    def set_range_min(range, min)
      if range[0] && range[0] >= min
        range
      elsif range[1].nil? || range[1] > min
        [min, range[1]]
      end
    end
  end
end
