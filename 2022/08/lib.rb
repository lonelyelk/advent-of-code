# frozen_string_literal: true

# https://adventofcode.com/2022/day/8
module Year2022
  module Day08
    def process_input(str)
      str.split("\n").reject(&:empty?).map { |l| l.chars.map(&:to_i) }
    end

    def problem1(input)
      visible = inside_in_lines(input).each_with_object({}) do |(line, x, key), acc|
        acc[key] ||= (line[...x].max < line[x] || line[(x + 1)..].max < line[x])
      end
      visible.count { |_k, v| v } + perimeter(input)
    end

    def problem2(input)
      scores = inside_in_lines(input).each_with_object(Hash.new(1)) do |(line, x, key), acc|
        acc[key] *= visibility_distances(line, x).inject(:*)
      end
      scores.values.max
    end

    private

    def perimeter(input)
      (input.size + input.first.size) * 2 - 4
    end

    def inside_in_lines(input)
      return to_enum(__method__, input) unless block_given?

      [input, input.transpose].each_with_index do |inp, i|
        (1...(inp.size - 1)).each do |y|
          (1...(inp[y].size - 1)).each do |x|
            yield(inp[y], x, i.zero? ? "#{x},#{y}" : "#{y},#{x}")
          end
        end
      end
    end

    def visibility_distances(line, pos)
      index_dir_left = line[...pos].rindex { |e| e >= line[pos] }
      visible_left = index_dir_left.nil? ? pos : pos - index_dir_left
      index_dir_right = line[(pos + 1)..].index { |e| e >= line[pos] }
      visible_right = index_dir_right.nil? ? line.size - pos - 1 : index_dir_right + 1
      [visible_left, visible_right]
    end
  end
end
