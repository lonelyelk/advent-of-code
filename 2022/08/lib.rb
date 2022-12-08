# frozen_string_literal: true

# https://adventofcode.com/2022/day/8
module Year2022
  module Day08
    def process_input(str)
      str.split("\n").reject(&:empty?).map { |l| l.chars.map(&:to_i) }
    end

    def problem1(input)
      visible = {}
      in_lines(input) do |line, x, key|
        visible[key] ||= (line[...x].max < line[x] || line[(x + 1)..].max < line[x])
      end
      visible.count { |_k, v| v } + input.size * 4 - 4
    end

    def problem2(input)
      scores = Hash.new(1)
      in_lines(input) do |line, x, key|
        scores[key] *= visibility_distances(line, x).inject(:*)
      end
      scores.values.max
    end

    private

    def in_lines(input)
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
      dir_left = index_dir_left.nil? ? pos : pos - index_dir_left
      index_dir_right = line[(pos + 1)..].index { |e| e >= line[pos] }
      dir_right = index_dir_right.nil? ? line.size - pos - 1 : index_dir_right + 1
      [dir_left, dir_right]
    end
  end
end
