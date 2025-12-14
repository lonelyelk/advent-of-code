# frozen_string_literal: true

# https://adventofcode.com/2025/day/10
module Year2025
  module Day10
    def process_input(str)
      str.split("\n").map do |line|
        md = line.match(/\[([.#]+)\]([()0-9, ]+)\{(.+)\}/)
        target = md[1]
        buttons = md[2].strip.split
        joltage = md[3].split(",").map(&:to_i)
        { target:, buttons:, joltage: }
      end
    end

    def problem1(input)
      process_input1(input).sum do |machine|
        (1..).detect do |num|
          machine[:buttons].combination(num).detect do |presses|
            presses.inject(&:^) == machine[:target]
          end
        end
      end
    end

    def problem2(input)
      process_input2(input).sum do |machine|
        init_cache(machine)
        presses(machine[:joltage], machine)
      end
    end

    private

    def process_input1(input)
      input.map do |inpt|
        {
          target: inpt[:target].chars.each_with_index.sum { |c, i| c == "#" ? 1 << i : 0 },
          buttons: inpt[:buttons].map { |str| str.scan(/\d+/).sum { |n| 1 << n.to_i } },
        }
      end
    end

    def process_input2(input)
      input.map do |inpt|
        {
          buttons: inpt[:buttons].map { |str| str.scan(/\d+/).map(&:to_i) },
          joltage: inpt[:joltage],
        }
      end
    end

    def init_cache(machine)
      @joltage_gain = {}
      @btn_presses = {}
      @patterns = Hash.new { |h, k| h[k] = [] }
      @patterns = [0, 1].repeated_permutation(machine[:buttons].size).each_with_object(@patterns) do |pressed, acc|
        acc[joltage_gain(pressed, machine).map { |j| j % 2 }].push(pressed)
      end
    end

    def joltage_gain(pressed, machine)
      @joltage_gain[pressed] ||=
        pressed.each_with_index.with_object(Array.new(machine[:joltage].size, 0)) do |(b, i), acc|
          machine[:buttons][i].each { |j| acc[j] += b }
        end
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def presses(joltage, machine)
      return 0 if joltage.all?(&:zero?)
      return Float::INFINITY if joltage.any?(&:negative?)

      target_leds = joltage.map { |j| j % 2 }

      @btn_presses[joltage] ||= @patterns[target_leds].inject(Float::INFINITY) do |total, pressed|
        gain = joltage_gain(pressed, machine)
        target = joltage.zip(gain).map { |arr| arr.inject(&:-) / 2 }
        [total, pressed.sum + 2 * presses(target, machine)].min
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end
end
