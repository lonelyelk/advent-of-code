# frozen_string_literal: true

require_relative "nets"

# https://adventofcode.com/2022/day/22
module Year2022
  module Day22
    include Nets

    def process_input(str)
      field, path = str.split("\n\n")
      board = {}
      field.each_line.with_index do |l, y|
        l.chars.each_with_index do |c, x|
          board[x + y * 1i] = c if [?#, ?.].include?(c)
        end
      end
      [board, path.chomp]
    end

    def problem1(input)
      board, path = input
      dir, pos = init(board)
      path.scan(/([RL])?(\d+)/).each do |(rot, mv)|
        dir = read_dir(dir, rot) if rot
        mv.to_i.times { pos = move_one(dir, pos, board) }
      end
      password(dir, pos)
    end

    def problem2(input, test_net: false)
      board, path = input
      init_cube(board, test_net)
      dir, pos = init(board)
      path.scan(/([RL])?(\d+)/).each do |(rot, mv)|
        dir = read_dir(dir, rot) if rot
        mv.to_i.times { dir, pos = move_one_cube(dir, pos, board) }
      end
      password(dir, pos)
    end

    private

    # rubocop:disable Metrics/AbcSize
    def next_pos(dir, pos, board)
      return pos + dir if board.key?(pos + dir)

      if dir.imag.zero?
        return board.keys.select { |c| c.imag == pos.imag }.minmax_by(&:real)[[1 + 0i, -1 + 0i].index(dir)]
      end

      board.keys.select { |c| c.real == pos.real }.minmax_by(&:imag)[[1i, -1i].index(dir)]
    end

    def next_pos_cube(dir, pos, board)
      return [dir, pos + dir] if board.key?(pos + dir)

      face = (dir.real.zero? ? pos.real : pos.imag).to_i / @side
      [dir * @net[dir][face][:rot], @net[dir][face][:trans][pos, @side]]
    end
    # rubocop:enable Metrics/AbcSize

    def init(board)
      dir = 1 + 0i
      pos = board.keys.select { |coord| coord.imag.zero? }.min_by(&:real)
      [dir, pos]
    end

    def init_cube(board, test_net)
      @net = test_net ? NET1 : NET2
      @side = Math.sqrt(board.keys.size / 6).to_i
    end

    def read_dir(dir, rot)
      dir * case rot
            when ?R
              1i
            when ?L
              -1i
            end
    end

    def move_one(dir, pos, board)
      maybe_next_pos = next_pos(dir, pos, board)
      case board[maybe_next_pos]
      when ?.
        maybe_next_pos
      when ?#
        pos
      end
    end

    def move_one_cube(dir, pos, board)
      maybe_next_dir, maybe_next_pos = next_pos_cube(dir, pos, board)
      case board[maybe_next_pos]
      when ?.
        [maybe_next_dir, maybe_next_pos]
      when ?#
        [dir, pos]
      end
    end

    def password(dir, pos)
      1000 * (pos.imag + 1) + 4 * (pos.real + 1) + dir_to_pass(dir)
    end

    def dir_to_pass(dir)
      (0..3).inject(1) do |d, i|
        return i if d == dir

        d * 1i
      end
    end
  end
end
