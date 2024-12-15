# frozen_string_literal: true

# https://adventofcode.com/2024/day/15
module Year2024
  module Day15
    def process_input(str)
      map_input, ops_input = str.split("\n\n")
      start = nil
      map = map_input.split("\n").each_with_object({}).with_index do |(line, acc), y|
        line.chars.each_with_index do |c, x|
          next if c == "."

          if c == "@"
            start = [x, y]
            next
          end

          acc[[x, y]] = c
        end
      end
      [start, map, ops_input.split("\n").join.chars]
    end

    def problem1(input)
      pos, map, ops = input.map(&:dup)
      ops.each do |op|
        n_pos = next_pos(pos, op)
        if map[n_pos].nil?
          pos = n_pos
        elsif map[n_pos] == "O"
          work_body = (0..).lazy.map do |mult|
            next_pos(n_pos, op, mult)
          end
          to_move = work_body.take_while { |coord| map[coord] == "O" }.to_a
          if map[next_pos(n_pos, op, to_move.size)].nil?
            map.delete(to_move.first)
            map[next_pos(to_move.last, op)] = "O"
            pos = n_pos
          end
        end
        # display(map, pos)
      end
      map.keys.select { |k| map[k] == "O" }.sum { |(x, y)| x + 100 * y }
    end

    def problem2(input)
    end

    def direction(dir, mult = 1)
      case dir
      when "^"
        [0, -mult]
      when ">"
        [mult, 0]
      when "v"
        [0, mult]
      else
        [-mult, 0]
      end
    end

    def next_pos(start, dir, mult = 1)
      start.zip(direction(dir, mult)).map(&:sum)
    end

    def display(map, pos)
      x_range, y_range = map.keys.transpose.map(&:minmax)
      y_range.first.upto(y_range.last).each do |y|
        x_range.first.upto(x_range.last).each do |x|
          if map[[x, y]].nil?
            print(pos == [x, y] ? "@" : ".")
          else
            print(map[[x, y]])
          end
        end
        puts
      end
    end
  end
end
