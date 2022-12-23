# frozen_string_literal: true

# https://adventofcode.com/2022/day/23
module Year2022
  module Day23
    MOVE_CONDITIONS = {
      -1i => [-1 - 1i, -1i, 1 - 1i].freeze,
      1i => [-1 + 1i, 1i, 1 + 1i].freeze,
      -1 => [-1 - 1i, -1, -1 + 1i].freeze,
      1 => [1 - 1i, 1, 1 + 1i].freeze,
    }.freeze
    POS_AROUND = MOVE_CONDITIONS.values.flatten.freeze

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
      field = input.dup
      10.times do |round|
        one_round(field, round)
      end
      x_min, x_max, y_min, y_max = field_size(field)
      (x_max - x_min + 1) * (y_max - y_min + 1) - field.keys.size
    end

    def problem2(input)
      field = input.dup
      round = 0
      loop do
        break if one_round(field, round).zero?

        round += 1
      end
      round + 1
    end

    private

    def one_round(field, rotate_count)
      next_set = first_half(field, rotate_count)
      moved = second_half(field, next_set[:no_no])
      field.compact!
      moved
    end

    def first_half(field, rotate_count)
      field.keys.each_with_object({ busy: {}, no_no: {} }) do |k, n_set|
        m = move_to(field, rotate_count, k)
        next if m.nil?

        dk = k + m
        if n_set[:busy][dk]
          n_set[:no_no][dk] = true
        else
          n_set[:busy][field[k] = dk] = true
        end
      end
    end

    def move_to(field, rotate_count, pos)
      return if POS_AROUND.all? { |dd| field[pos + dd].nil? }

      MOVE_CONDITIONS.keys.rotate(rotate_count).detect { |d| MOVE_CONDITIONS[d].all? { |dd| field[pos + dd].nil? } }
    end

    def second_half(field, no_move_to)
      field.keys.count do |k|
        if field[k] != k && !no_move_to[field[k]]
          nk, field[k] = [field[k], nil]
          field[nk] = nk
          true
        else
          field[k] = k
          false
        end
      end
    end

    def field_size(field)
      %i[real imag].map { |oper| field.keys.map(&oper).minmax }.flatten
    end

    def print_field(field)
      x_min, x_max, y_min, y_max = field_size(field)
      puts
      (y_min..y_max).each do |y|
        (x_min..x_max).each do |x|
          print(field[Complex(x, y)] ? ?# : ?.)
        end
        puts
      end
    end
  end
end
