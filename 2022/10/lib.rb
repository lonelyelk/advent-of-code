# frozen_string_literal: true

# https://adventofcode.com/2022/day/10
module Year2022
  module Day10
    def process_input(str)
      str.split("\n").reject(&:empty?).map do |line|
        op, arg = line.split(" ", 2)
        arg.nil? ? [op] : [op, arg.to_i]
      end
    end

    def problem1(input)
      cpu_state = input.each_with_object({ x: 1, dx: 0, c: 0, str: [] }) do |(op, arg), state|
        state[:x] += state[:dx]
        state[:dx] = arg.to_i
        each_cycle(state, op) do
          check_strength(state)
        end
      end
      cpu_state[:str].inject(&:+)
    end

    def problem2(input)
      cpu_state = input.each_with_object({ x: 1, dx: 0, c: 0, out: [] }) do |(op, arg), state|
        state[:x] += state[:dx]
        state[:dx] = arg.to_i
        each_cycle(state, op) do
          draw_pixel(state)
        end
      end
      cpu_state[:out].map(&:join)
    end

    private

    def check_strength(state)
      state[:str].push(state[:x] * state[:c]) if state[:c] % 40 == 20
    end

    def draw_pixel(state)
      row, col = (state[:c] - 1).divmod(40)
      state[:out][row] ||= []
      state[:out][row][col] = (state[:x] - col).abs < 2 ? ?# : ?.
    end

    def each_cycle(state, operation)
      if operation == "addx"
        state[:c] += 1
        yield
      end
      state[:c] += 1
      yield
    end
  end
end
