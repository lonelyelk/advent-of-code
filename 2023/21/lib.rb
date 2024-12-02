# frozen_string_literal: true

# https://adventofcode.com/2023/day/21
module Year2023
  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  module Day21
    STEPS = [Complex(0, 1), Complex(0, -1), Complex(1, 0), Complex(-1, 0)].freeze

    def process_input(str)
      lines = str.split("\n")
      lines.each_with_index.inject({ garden: {}, r_size: lines.size, i_size: lines.first.size }) do |acc, (line, r)|
        line.chars.each_with_index.with_object(acc) do |(c, i), g|
          g[:garden][Complex(r, i)] = true if c == "#"
          g[:start] = Complex(r, i) if c == "S"
        end
      end
    end

    def problem1(input, steps = 64)
      boundaries!(input)
      steps.times.inject({ input[:start] => true }) do |positions, _|
        positions.each_with_object({}) do |(pos, _), np|
          STEPS.each do |diff|
            n = pos + diff
            np[n] = true unless input[:garden][n]
          end
        end
      end.keys.size
    end

    # This only works for "production" data, as it has nice straight paths ensuring somewhat
    # symmetrical reach
    def problem2(input, steps = 26_501_365)
      boundaries!(input)
      states = {
        mc: input[:start],
        tl: Complex(0, 0),
        tc: Complex(input[:r_size] / 2, 0),
        tr: Complex(input[:r_size] - 1, 0),
        mr: Complex(input[:r_size] - 1, input[:i_size] / 2),
        br: Complex(input[:r_size] - 1, input[:i_size] - 1),
        bc: Complex(input[:r_size] / 2, input[:i_size] - 1),
        bl: Complex(0, input[:i_size] - 1),
        ml: Complex(0, input[:i_size] / 2),
      }.each_with_object({}) do |(key, start), pos_num|
        cache = {}
        positions = { start => true }
        pos_num[key] = { final: {}, flow: {} }
        step = 0
        loop do
          cache[step] = positions
          pos_num[key][:flow][step] = positions.size
          positions = positions.each_with_object({}) do |(pos, _), np|
            STEPS.each do |diff|
              n = pos + diff
              np[n] = true unless input[:garden][n]
            end
          end
          if cache[step - 1] == positions
            pos_num[key][:final][(step - 1) % 2] = positions.size
            pos_num[key][:final][step % 2] = cache[step].size
            pos_num[key][:final][:max] = step
            break
          end
          step += 1
        end
        puts key
      end
      count = states[:mc][:final][steps % 2]
      steps -= input[:start].real + 1
      angle_count = 1
      while steps.positive?
        %i[tc mr bc ml].each do |key|
          count += states[key][:final][:max] < steps ? states[key][:final][steps % 2] : states[key][:flow][steps]
        end
        steps -= input[:start].real + 1
        %i[tl tr br bl].each do |key|
          count +=
            if states[key][:final][:max] < steps
              states[key][:final][steps % 2] * angle_count
            else
              states[key][:flow][steps] * angle_count
            end
        end
        angle_count += 1
        steps -= input[:start].real
      end
      count
    end

    private

    def boundaries!(garden)
      (-1..garden[:r_size]).each do |r|
        garden[:garden][Complex(r, -1)] = garden[:garden][Complex(r, garden[:i_size])] = true
      end
      (-1..garden[:i_size]).each do |i|
        garden[:garden][Complex(-1, i)] = garden[:garden][Complex(garden[:r_size], i)] = true
      end
    end

    def init_garden
      Hash.new { |h, k| h[k] = {} }
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
end
