# frozen_string_literal: true

# https://adventofcode.com/2022/day/9
module Year2022
  module Day09
    DIR_MAP = {
      ?L => -1,
      ?R => 1,
      ?U => 1i,
      ?D => -1i,
    }
    STRAIGHT_MOVES = DIR_MAP.values
    DIAG_MOVES = [1 + 1i, -1 + 1i, -1 - 1i, 1 - 1i]

    def process_input(str)
      str.split("\n").reject(&:empty?).map do |line|
        dir, num = line.split(" ", 2)
        [dir, num.to_i]
      end
    end

    def problem1(input)
      h = 0i
      t = 0i
      history = [t]
      input.each do |(dir, num)|
        num.times do
          h += DIR_MAP[dir]
          next if (t - h).abs < 2

          if t.real == h.real || t.imaginary == h.imaginary
            move = STRAIGHT_MOVES.min_by { |e| (t + e - h).abs }
            t += move
            history.push(t)
          else
            move = DIAG_MOVES.min_by { |e| (t + e - h).abs }
            t += move
            history.push(t)
          end
        end
      end
      history.uniq.length
    end

    def problem2(input)
      rope = Array.new(10, 0i)
      history = [0i]
      input.each do |(dir, num)|
        num.times do
          rope[0] += DIR_MAP[dir]
          (1...rope.size).each do |i|
            next if (rope[i] - rope[i - 1]).abs < 2

            moves =
              if rope[i].real == rope[i - 1].real || rope[i].imaginary == rope[i - 1].imaginary
                STRAIGHT_MOVES
              else
                DIAG_MOVES
              end
            move = moves.min_by { |e| (rope[i] + e - rope[i - 1]).abs }
            rope[i] += move
          end
          history.push(rope[-1])
        end
      end
      history.uniq.size
    end
  end
end
