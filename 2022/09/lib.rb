# frozen_string_literal: true

# https://adventofcode.com/2022/day/9
module Year2022
  module Day09
    DIR_MAP = {
      ?L => -1,
      ?R => 1,
      ?U => 1i,
      ?D => -1i,
    }.freeze
    MOVES = [1, -1, 1i, -1i, 1 + 1i, -1 + 1i, -1 - 1i, 1 - 1i].freeze

    def process_input(str)
      str.split("\n").reject(&:empty?).map do |line|
        dir, num = line.split(" ", 2)
        [dir, num.to_i]
      end
    end

    def problem1(input)
      rope_tail_history_size(input, 2)
    end

    def problem2(input)
      rope_tail_history_size(input, 10)
    end

    private

    def rope_tail_history_size(input, length)
      rope = Array.new(length, 0i)
      history = [0i]
      input.each do |(dir, num)|
        process_command(dir, num, rope, history)
      end
      history.uniq.size
    end

    def process_command(dir, num, rope, history)
      num.times do
        rope[0] += DIR_MAP[dir]
        (1...rope.size).each do |i|
          rope[i] = maybe_move_section(rope[i], rope[i - 1])
        end
        history.push(rope[-1])
      end
    end

    def maybe_move_section(current, prev)
      return current if (current - prev).abs < 2

      move = MOVES.min_by { |e| (current + e - prev).abs }
      current + move
    end
  end
end
