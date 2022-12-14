# frozen_string_literal: true

# https://adventofcode.com/2022/day/14
module Year2022
  module Day14
    class EndlessVoid < RuntimeError; end

    def process_input(str)
      str.split("\n").reject(&:empty?).each_with_object(hash_2d) do |line, parsed|
        split_to_pairs(line).each_cons(2) do |(prev_x, prev_y), (x, y)|
          Range.new(*[y, prev_y].minmax).each do |yy|
            Range.new(*[x, prev_x].minmax).each do |xx|
              parsed[xx][yy] = ?#
            end
          end
        end
      end
    end

    def problem1(input)
      count = 0
      loop do
        drop([500, 0], input)
        count += 1
      end
    rescue EndlessVoid
      count
    end

    def problem2(input)
      count = 0
      floor = input.values.map(&:keys).map(&:max).max + 2
      loop do
        return count unless input[500][0].nil?

        drop_floor([500, 0], input, floor)
        count += 1
      end
    end

    def print_state(input)
      x_min, x_max = input.keys.minmax
      y_min, y_max = input.values.map(&:keys).flatten.minmax
      puts
      (y_min..y_max).each do |y|
        (x_min..x_max).each do |x|
          print(input[x][y] || " ")
        end
        puts
      end
    end

    private

    def hash_2d
      Hash.new { |hsh, key| hsh[key] = {} }
    end

    def split_to_pairs(line)
      line.split(" -> ").map { |pair| pair.split(",").map(&:to_i) }
    end

    def drop(point, input)
      stone_under = find_stone_under(point, input) || raise(EndlessVoid)

      x = [point[0] - 1, point[0] + 1].detect { |xx| input[xx][stone_under].nil? }
      if x
        drop([x, stone_under], input)
      else
        input[point[0]][stone_under - 1] = ?o
        input
      end
    end

    def drop_floor(point, input, floor)
      stone_under = find_stone_under(point, input)
      if stone_under.nil?
        input[point[0]][floor - 1] = ?o
        return input
      end

      x = [point[0] - 1, point[0] + 1].detect { |xx| input[xx][stone_under].nil? }
      if x
        drop_floor([x, stone_under], input, floor)
      else
        input[point[0]][stone_under - 1] = ?o
        input
      end
    end

    def find_stone_under(point, input)
      input[point[0]].keys.sort.detect { |k| k > point[1] }
    end
  end
end
