# frozen_string_literal: true

# https://adventofcode.com/2023/day/17
module Year2023
  module Day17
    def process_input(str)
      str.split("\n").map { |line| line.chars.map(&:to_i) }
    end

    def problem1(input)
      path = Array.new(input.size) { |i| Array.new(input[i].size) { |_| {} } }
      path[0][0] = { [0, 0, 0, 0] => 0 }
      to_process = { [0, 0, [0, 0, 0, 0]] => 0 }
      until to_process.empty?
        target_heat = heat_loss(path)
        to_process = to_process.each_with_object({}) do |((y, x, len), heat), tp|
          positions_with_index(x, y, input, len).each do |(yy, xx), i|
            pos_len = 4.times.map { |ii| ii == i ? len[i] + 1 : 0 }
            pos_heat = heat + input[yy][xx]
            next if target_heat && pos_heat > target_heat

            if path[yy][xx][pos_len].nil? || path[yy][xx][pos_len] > pos_heat
              path[yy][xx][pos_len] = pos_heat
              tp[[yy, xx, pos_len]] = pos_heat
            end
          end
        end
      end
      heat_loss(path)
    end

    def problem2(input)
      path = Array.new(input.size) { |i| Array.new(input[i].size) { |_| {} } }
      path[0][0] = { [0, 0, 0, 0] => 0 }
      to_process = { [0, 0, [0, 0, 0, 0]] => 0 }
      until to_process.empty?
        target_heat = ultra_heat_loss(path)
        to_process = to_process.each_with_object({}) do |((y, x, len), heat), tp|
          ultra_positions_with_index(x, y, input, len).each do |(yy, xx), i|
            pos_len = 4.times.map { |ii| ii == i ? len[i] + 1 : 0 }
            pos_heat = heat + input[yy][xx]
            next if target_heat && pos_heat > target_heat

            if path[yy][xx][pos_len].nil? || path[yy][xx][pos_len] > pos_heat
              path[yy][xx][pos_len] = pos_heat
              tp[[yy, xx, pos_len]] = pos_heat
            end
          end
        end
      end
      ultra_heat_loss(path)
    end

    private

    # rubocop:disable Naming/MethodParameterName
    def possible_moves(x, y)
      [[y - 1, x], [y, x + 1], [y + 1, x], [y, x - 1]]
    end

    def positions_with_index(x, y, input, len)
      possible_moves(x, y).each_with_index.map do |(yy, xx), i|
        next if len[i] >= 3 || len[(i + 2) % 4].positive? || outside?(xx, yy, input)

        [[yy, xx], i]
      end.compact
    end

    def outside?(x, y, input)
      y.negative? || x.negative? || y >= input.size || x >= input.first.size
    end

    def ultra_positions_with_index(x, y, input, len)
      current_dir = len.index(&:positive?)
      no_turn = current_dir && len[current_dir] < 4
      possible_moves(x, y).each_with_index.map do |(yy, xx), i|
        next if (i != current_dir && no_turn) || len[i] >= 10 || len[(i + 2) % 4].positive? || outside?(xx, yy, input)

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
