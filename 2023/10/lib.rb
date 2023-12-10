# frozen_string_literal: true

# https://adventofcode.com/2023/day/10
module Year2023
  module Day10
    PIPES = {
      "|" => [true, false, true, false].freeze,
      "-" => [false, true, false, true].freeze,
      "L" => [true, true, false, false].freeze,
      "J" => [true, false, false, true].freeze,
      "7" => [false, false, true, true].freeze,
      "F" => [false, true, true, false].freeze,
      "." => [false, false, false, false].freeze,
    }.freeze
    DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]].map(&:freeze).freeze

    def process_input(str)
      str.split("\n").reject(&:empty?)
    end

    def problem1(input)
      pos = nil
      input.each_with_index do |line, y|
        line.chars.each_with_index do |c, x|
          next unless c == "S"

          pos = [y, x]
          break
        end
        break unless pos.nil?
      end
      pipes = replace_start(input)
      next_left, next_right = next_positions(pipes, pos)
      path_left = {pos => true, next_left => true}
      path_right = {pos => true, next_right => true}
      loop do
        next_left = next_positions(pipes, next_left).reject { |ps| path_left[ps] || path_right[ps] }.first
        break if next_left.nil?

        path_left[next_left] = true
        next_right = next_positions(pipes, next_right).reject { |ps| path_left[ps] || path_right[ps] }.first
        break if next_right.nil?
 
        path_right[next_right] = true
      end
      [path_left.size, path_right.size].max - 1
    end

    def problem2(input)
    end

    private

    def replace_start(input)
      input.map.with_index do |line, y|
        line.chars.map.with_index do |c, x|
          if c == "S"
            dirs = DIRECTIONS.map.with_index do |dir, d|
              y_d, x_d = [y, x].zip(dir).map(&:sum)
              (0...input.size).include?(y_d) && (0...line.length).include?(x_d) &&
                PIPES[input[y_d][x_d]][(d + 2) % 4]
            end
            PIPES.key(dirs)
          else
            c
          end
        end
      end
    end

    def next_positions(pipes, pos)
      dirs = []
      DIRECTIONS.each_with_index do |dir, d|
        next unless PIPES[pipes[pos[0]][pos[1]]][d]

        dirs.push(pos.zip(dir).map(&:sum))
      end
      dirs
    end

    def connect_north(c)
      PIPES[c][0]
    end

    def connect_east(c)
      PIPES[c][1]
    end

    def connect_south(c)
      PIPES[c][2]
    end

    def connect_west(c)
      PIPES[c][3]
    end
  end
end
