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
      pos = find_start_pos(input)
      pipes = replace_start(input)
      path_left, path_right = find_loop(pipes, pos)
      [path_left.size, path_right.size].max - 1
    end

    def problem2(input)
      pos = find_start_pos(input)
      pipes = replace_start(input)
      path_left, path_right = find_loop(pipes, pos)
      pipes = remove_non_loop(pipes, path_left.merge(path_right))
      pipes.each_with_index do |line, y|
        line.each_with_index do |c, x|
          next unless c == "."

          if x.zero? || y.zero? || pipes[y - 1][x] == "O" || pipes[y][x - 1] == "O"
            pipes[y][x] = "O"
          else
            cut = pipes[y][...x].join.scan(/\||L-*7|F-*J/).size
            pipes[y][x] = cut.even? ? "O" : "I"
          end
        end
      end
      pipes.sum { |line| line.count("I") }
    end

    private

    def find_start_pos(input)
      pos = nil
      input.each_with_index do |line, y|
        line.chars.each_with_index do |c, x|
          next unless c == "S"

          pos = [y, x]
          break
        end
        break unless pos.nil?
      end
      pos
    end

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

    def find_loop(pipes, pos)
      next_left, next_right = next_positions(pipes, pos)
      path_left = { pos => true, next_left => true }
      path_right = { pos => true, next_right => true }
      loop do
        next_left = next_positions(pipes, next_left).reject { |ps| path_left[ps] || path_right[ps] }.first
        break if next_left.nil?

        path_left[next_left] = true
        next_right = next_positions(pipes, next_right).reject { |ps| path_left[ps] || path_right[ps] }.first
        break if next_right.nil?

        path_right[next_right] = true
      end
      [path_left, path_right]
    end

    def next_positions(pipes, pos)
      dirs = []
      DIRECTIONS.each_with_index do |dir, d|
        next unless PIPES[pipes[pos[0]][pos[1]]][d]

        dirs.push(pos.zip(dir).map(&:sum))
      end
      dirs
    end

    def remove_non_loop(pipes, path)
      pipes.map.with_index do |line, y|
        line.map.with_index do |c, x|
          path[[y, x]] ? c : "."
        end
      end
    end
  end
end
