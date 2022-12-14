# frozen_string_literal: true

# https://adventofcode.com/2022/day/14
module Year2022
  module Day14
    class EndlessVoid < RuntimeError; end
    class FullOfSand < RuntimeError; end

    def process_input(str)
      parsed = Hash.new { |hsh, key| hsh[key] = {} }
      str.split("\n").reject(&:empty?).each do |line|
        pairs = line.split(" -> ").map { |pair| pair.split(",").map(&:to_i) }
        pairs.each_with_index do |(x, y), i|
          if i.zero?
            parsed[x][y] = ?#
          else
            prev_x, prev_y = pairs[i - 1]
            if x == prev_x
              Range.new(*[y, prev_y].minmax).each do |yy|
                parsed[x][yy] = ?#
              end
            else
              Range.new(*[x, prev_x].minmax).each do |xx|
                parsed[xx][y] = ?#
              end
            end
          end
        end
      end
      parsed
    end

    def problem1(input)
      count = 0
      while true
        drop([500, 0], input)
        count += 1
      end
    rescue EndlessVoid
      count
    end

    def problem2(input)
      count = 1
      floor = input.values.map(&:keys).map(&:max).max + 2
      while true
        drop_floor([500, 0], input, floor)
        count += 1
      end
    rescue FullOfSand
      count
    end

    def print_state(input)
      x_min, x_max = input.keys.minmax
      y_min, y_max = input.values.map { |h| h.keys.minmax }.flatten.minmax
      puts
      (y_min..y_max).each do |y|
        (x_min..x_max).each do |x|
          print(input[x][y] || " ")
        end
        puts
      end
    end

    private

    def drop(point, input)
      stones_under = input[point[0]].keys.select { |k| k > point[1] }
      raise EndlessVoid if stones_under.empty?

      y_pos = stones_under.min - 1
      if input[point[0] - 1][y_pos + 1].nil?
        drop([point[0] - 1, y_pos + 1], input)
      elsif input[point[0] + 1][y_pos + 1].nil?
        drop([point[0] + 1, y_pos + 1], input)
      else
        input[point[0]][y_pos] = ?o
        input
      end
    end

    def drop_floor(point, input, floor)
      stones_under = input[point[0]].keys.select { |k| k > point[1] }
      if stones_under.empty?
        input[point[0]][floor - 1] = ?o
        return input
      end
      y_pos = stones_under.min - 1
      if input[point[0] - 1][y_pos + 1].nil?
        drop_floor([point[0] - 1, y_pos + 1], input, floor)
      elsif input[point[0] + 1][y_pos + 1].nil?
        drop_floor([point[0] + 1, y_pos + 1], input, floor)
      elsif y_pos > 0
        input[point[0]][y_pos] = ?o
        input
      else
        raise FullOfSand
      end
    end
  end
end
