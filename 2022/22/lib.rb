# frozen_string_literal: true

# https://adventofcode.com/2022/day/22
module Year2022
  module Day22
    def process_input(str)
      field, path = str.split("\n\n")
      board = {}
      field.each_line.with_index do |l, y|
        l.chars.each_with_index do |c, x|
          if [?#, ?.].include?(c)
            board[x + y * 1i] = c
          end
        end
      end
      [board, path.chomp]
    end

    def problem1(input)
      board, path = input
      dir = 1
      pos = board.keys.select { |coord| coord.imag.zero? }.min_by(&:real)
      path.scan(/(\d+)?([RL])(\d+)/).each do |(pre, rot, mv)|
        pre.to_i.times { pos = move_one(dir, pos, board) } if pre
        dir *= rot == ?R ? 1i : -1i
        mv.to_i.times { pos = move_one(dir, pos, board) }
      end
      1000 * (pos.imag + 1) + 4 * (pos. real + 1) + dir_to_pass(dir)
    end

    def problem2(input)
    end

    private

    def move_one(dir, pos, board)
      maybe_next_pos = next_pos(dir, pos, board)
      case board[maybe_next_pos]
      when ?.
        maybe_next_pos
      when ?#
        pos
      end
    end

    def next_pos(dir, pos, board)
      return pos + dir if board.key?(pos + dir)

      case dir
      when 1
        board.keys.select { |coord| coord.imag == pos.imag }.min_by(&:real)
      when -1
        board.keys.select { |coord| coord.imag == pos.imag }.max_by(&:real)
      when 1i
        board.keys.select { |coord| coord.real == pos.real }.min_by(&:imag)
      when -1i
        board.keys.select { |coord| coord.real == pos.real }.max_by(&:imag)
      end
    end

    def dir_to_pass(dir)
      (0..3).inject(1) do |d, i|
        return i if d == dir
        d * 1i
      end
    end
  end
end
