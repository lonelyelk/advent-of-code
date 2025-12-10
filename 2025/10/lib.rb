# frozen_string_literal: true

# https://adventofcode.com/2025/day/10
module Year2025
  module Day10
    def process_input(str)
      str.split("\n").map do |line|
        md = line.match(/\[([.#]+)\]([()0-9, ]+)\{(.+)\}/)
        target = md[1].chars.each_with_index.sum { |c, i| c == "#" ? 1 << i : 0 }
        buttons = md[2].strip.split(" ").map do |str|
          str.scan(/\d+/).sum { |n| 1 << n.to_i }
        end
        joltage = md[3].split(",").map(&:to_i)
        { target:, buttons:, joltage: }
      end
    end

    def problem1(input)
      input.sum do |machine|
        (1..).detect do |num|
          machine[:buttons].combination(num).detect do |presses|
            presses.inject(&:^) == machine[:target]
          end
        end
      end
    end

    def problem2(input)
      input.sum do |machine|
        p machine
        (machine[:joltage].max..).detect do |num|
          # raise "FAILED" if num > 20

          machine[:buttons].repeated_combination(num).detect do |presses|
            if presses.count(10) == 3 && presses.count(12) == 3 && presses.count(8) == 1 && presses.count(5) == 1 && presses.count(3) == 2
              p presses
            end
            machine[:joltage] == presses.inject(Array.new(machine[:joltage].size, 0)) do |acc, btn|
              if presses.count(10) == 3 && presses.count(12) == 3 && presses.count(8) == 1 && presses.count(5) == 1 && presses.count(3) == 2
                p acc
                p btn
              end
              acc.map.with_index { |j, i| j + (1 & (btn >> i)) }
            end
            # if presses.count(10) == 3 && presses.count(12) == 3 && presses.count(8) == 1 && presses.count(5) == 1 && presses.count(3) == 2
            #   p state
            # end
            # state[:joltage] == machine[:joltage] && state[:ind] == machine[:target]
          end
        end
      end
    end

    private

    def press_button(btn, state)
      {
        ind: state[:ind] ^ btn,
        joltage: state[:joltage].map.with_index { |j, i| j + (1 & (btn >> i)) },
      }
    end
  end
end
