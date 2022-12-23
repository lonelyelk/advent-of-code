# frozen_string_literal: true

# https://adventofcode.com/2022/day/23
module Year2022
  module Day23
    MOVE_CONDITIONS = {
      -1i => [-1 - 1i, -1i, 1 - 1i].freeze,
      1i => [-1 + 1i, 1i, 1 + 1i].freeze,
      -1 => [-1 - 1i, -1, -1 + 1i].freeze,
      1 => [1 - 1i, 1, 1 + 1i].freeze,
    }
    POS_AROUND = MOVE_CONDITIONS.values.flatten
    def process_input(str)
      h = {}
      str.each_line.with_index do |l, y|
        l.chars.each_with_index do |c, x|
          next unless c == ?#

          n = x + y * 1i
          h[n] = n
        end
      end
      h
    end

    def problem1(input)
      h = input.dup
      a = [-1, 0, 1]
      10.times do |rot|
        next_busy = {}
        next_no_no = {}
        h.keys.each do |k|
          next if POS_AROUND.all? { |dd| h[k + dd].nil? }

          m = MOVE_CONDITIONS.keys.rotate(rot).detect { |d| MOVE_CONDITIONS[d].all? { |dd| h[k + dd].nil? } }
          next if m.nil?

          if next_busy[k + m]
            next_no_no[k + m] = true
          else
            h[k] = k + m
            next_busy[k + m] = true
          end
        end
        h.keys.each do |k|
          if next_no_no[h[k]]
            h[k] = k
          elsif h[k] != k
            nk, h[k] = [h[k], nil]
            h[nk] = nk
          end
        end
        h.reject! { |_, v| v.nil? }
      end
      x_min, x_max = h.keys.map(&:real).minmax
      y_min, y_max = h.keys.map(&:imag).minmax
      (x_max - x_min + 1) * (y_max - y_min + 1) - h.keys.size
    end

    def problem2(input)
      h = input.dup
      a = [-1, 0, 1]
      round = 0
      loop do
        next_busy = {}
        next_no_no = {}
        moved = 0
        h.keys.each do |k|
          next if POS_AROUND.all? { |dd| h[k + dd].nil? }

          m = MOVE_CONDITIONS.keys.rotate(round).detect { |d| MOVE_CONDITIONS[d].all? { |dd| h[k + dd].nil? } }
          next if m.nil?

          if next_busy[k + m]
            next_no_no[k + m] = true
          else
            h[k] = k + m
            next_busy[k + m] = true
          end
        end
        h.keys.each do |k|
          if next_no_no[h[k]]
            h[k] = k
          elsif h[k] != k
            moved += 1
            nk, h[k] = [h[k], nil]
            h[nk] = nk
          end
        end
        h.reject! { |_, v| v.nil? }
        break if moved == 0
        round += 1
      end
      round + 1
    end

    private

    def print_field(hash)
      x_min, x_max = hash.keys.map(&:real).minmax
      y_min, y_max = hash.keys.map(&:imag).minmax
      puts
      (y_min..y_max).each do |y|
        (x_min..x_max).each do |x|
          print(hash[Complex(x, y)] ? ?# : ?.)
        end
        puts
      end
    end
  end
end
