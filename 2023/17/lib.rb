# frozen_string_literal: true

# https://adventofcode.com/2023/day/17
module Year2023
  module Day17
    def process_input(str)
      str.split("\n").map { |line| line.chars.map(&:to_i) }
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
    def problem1(input)
      path, to_process = init_path(input)
      until to_process.empty?
        target_heat = heat_loss(path)
        to_process = to_process.each_with_object({}) do |((y, x, len), heat), tp|
          positions_with_index(x, y, len, input).each do |(yy, xx), i|
            pos_heat = heat + input[yy][xx]
            next if target_heat && pos_heat > target_heat

            pos_len = next_position_lengths(len, i)
            if path[yy][xx][pos_len].nil? || path[yy][xx][pos_len] > pos_heat
              path[yy][xx][pos_len] = tp[[yy, xx, pos_len]] = pos_heat
            end
          end
        end
      end
      heat_loss(path)
    end

    def problem2(input)
      path, to_process = init_path(input)
      until to_process.empty?
        target_heat = ultra_heat_loss(path)
        to_process = to_process.each_with_object({}) do |((y, x, len), heat), tp|
          ultra_positions_with_index(x, y, len, input).each do |(yy, xx), i|
            pos_heat = heat + input[yy][xx]
            next if target_heat && pos_heat > target_heat

            pos_len = next_position_lengths(len, i)
            if path[yy][xx][pos_len].nil? || path[yy][xx][pos_len] > pos_heat
              path[yy][xx][pos_len] = tp[[yy, xx, pos_len]] = pos_heat
            end
          end
        end
      end
      ultra_heat_loss(path)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength

    private

    def init_path(input)
      lengths = [0, 0, 0, 0]
      path = Array.new(input.size) { |i| Array.new(input[i].size) { |_| {} } }
      path[0][0] = { lengths => 0 }
      to_process = { [0, 0, lengths] => 0 }
      [path, to_process]
    end

    def next_position_lengths(lengths, direction_index)
      4.times.map { |i| i == direction_index ? lengths[direction_index] + 1 : 0 }
    end

    # rubocop:disable Naming/MethodParameterName
    def possible_moves(x, y)
      [[y - 1, x], [y, x + 1], [y + 1, x], [y, x - 1]]
    end

    def positions_with_index(x, y, len, input)
      possible_moves(x, y).each_with_index.map do |(yy, xx), i|
        next if len[i] >= 3 || len[(i + 2) % 4].positive? || outside?(xx, yy, input)

        [[yy, xx], i]
      end.compact
    end

    def outside?(x, y, input)
      y.negative? || x.negative? || y >= input.size || x >= input.first.size
    end

    def ultra_positions_with_index(x, y, len, input)
      possible_moves(x, y).each_with_index.map do |(yy, xx), i|
        if (len[i].zero? && (1...4).include?(len.max)) ||
           len[i] >= 10 || len[(i + 2) % 4].positive? ||
           outside?(xx, yy, input)
          next
        end

        [[yy, xx], i]
      end.compact
    end
    # rubocop:enable Naming/MethodParameterName

    def heat_loss(path)
      path[path.size - 1][path.first.size - 1].values.min
    end

    def ultra_heat_loss(path)
      path[path.size - 1][path.first.size - 1].select do |len, _|
        current_dir = len.index(&:positive?)
        (4..10).include?(len[current_dir])
      end.values.min
    end
  end
end
