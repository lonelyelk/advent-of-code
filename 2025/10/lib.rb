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
        free = {}
        fixed = {}
        contrib = machine[:joltage].size.times.map do |i|
          machine[:buttons].select { |btn| (btn & 1 << i).positive? }
        end
        biggest_groups = machine[:buttons].group_by { |b| contrib.count { |c| c.include?(b) } }
        biggest = biggest_groups[biggest_groups.keys.max]
        p contrib
        loop do
          p [free, fixed]
          contrib.each_with_index do |c, i|
            fr = c.select { |b| free.key?(b) }
            fx = c.select { |b| fixed.key?(b) }
            to_fix = c - fr - fx
            next unless to_fix.size == 1

            fr.each { |b| free[b] = [free[b], machine[:joltage][i]].min }
            free_block = fr.size.positive? ? " - (#{fr.map { |b| "{#{b}}" }.join(" + ")})" : ""
            fixed_block = fx.size.positive? ? " - (#{fx.map { |b| "{#{b}}" }.join(" + ")})" : ""
            fixed[to_fix.first] = "#{machine[:joltage][i]}#{free_block}#{fixed_block}"
          end
          break if fixed.size + free.size == machine[:buttons].size

          to_free_cand = machine[:buttons].select do |b|
            !fixed.key?(b) && !free.key?(b)
          end.group_by do |b|
            contrib.count { |c| c.include?(b) }
          end
          to_free = to_free_cand[to_free_cand.keys.max].min_by do |b|
            contrib.select { |c| c.include?(b) }.sum { |c| (c - free.keys).size }
          end
          free[to_free] = contrib.filter_map.with_index { |c, i| machine[:joltage][i] if c.include?(to_free) }.min
        end
        p [contrib, fixed, free]
        free.each_key do |b|
          machine[:joltage].each_with_index do |j, i|
            free[b] = [free[b], j].min unless (1 & (b >> i)).zero?
          end
        end
        presses = free.each_key.with_object({}) { |b, acc| acc[b] = 0 }
        p free.values.map { |m| m + 1 }.inject(&:*)
        min = machine[:joltage].sum * 1000
        total = free.values.map { |m| m + 1 }.inject(&:*) || 1
        last_found_presses = {}
        total.times do |count|
          p [count, total, min, presses] if count % 10_000 == 0
          # p free.values.map { |m| m + 1 }.inject(&:*)
          solved = fixed.dup
          free.each_key do |btn|
            if presses[btn] < free[btn]
              presses[btn] += 1
              break
            else
              presses[btn] = 0
            end
          end

          pressed = solve_from_pressed(presses, solved)
          break if !last_found_presses.empty? && last_found_presses.all? do |b, n|
            n < presses[b]
          end
          next if pressed.values.any?(&:negative?)
          next if presses.values.sum >= min

          joltage = pressed.each_with_object(Array.new(machine[:joltage].size, 0)) do |(btn, val), acc|
            machine[:joltage].size.times do |i|
              acc[i] += ((btn >> i) & 1) * val
            end
          end
          # p([pressed, joltage]) unless pressed.values.any?(&:negative?)
          next unless joltage == machine[:joltage]

          cand = pressed.values.sum
          next unless cand < min

          min = cand
          puts "FOUND"
          p min
          p pressed
          p presses
          last_found_presses = presses.dup
        end
        # p solutions.min
        # solutions.min
        min
      end
    end

    private

    def solve_from_pressed(presses, solved)
      pressed = presses.dup
      loop do
        solved = solved.each_with_object({}) do |(btn, expr), acc|
          pressed.each do |b, val|
            expr = expr.gsub("{#{b}}", val.to_s)
          end
          if expr.include?("{")
            acc[btn] = expr
          else
            pressed[btn] = eval(expr)
          end
        end
        break if solved.empty?
      end
      pressed
    end

    def next_free_state(joltage, free)
      if free.values.all?(&:zero?)
        free[free.keys.first] = joltage.size.filter_map { |i| joltage[i] if free.keys.first.anybits?(1 << i) }.min
      else
      end
    end
  end
end
