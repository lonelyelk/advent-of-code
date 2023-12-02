# frozen_string_literal: true

# https://adventofcode.com/2023/day/2
module Year2023
  module Day02
    TARGET_GAME = {
      red: 12,
      green: 13,
      blue: 14,
    }.freeze

    def process_input(str)
      str.split("\n").reject(&:empty?).each_with_object({}) do |line, processed|
        md = line.match(/Game (\d+):(.+)$/)
        game = md[2].split(';').map do |set|
          set.split(',').each_with_object({}) do |pick, obj|
            num, color = pick.split(' ')
            obj[color.strip.to_sym] = num.to_i
          end
        end
        processed[md[1].to_i] = game
      end
    end

    def problem1(input)
      input.select do |id, game|
        game.all? do |set|
          !set.any? { |color, num| TARGET_GAME[color] < num }
        end
      end.keys.sum
    end

    def problem2(input)
      input.values.sum do |game|
        game.inject do |acc, set|
          %i[red green blue].each_with_object({}) do |color, obj|
            obj[color] = [acc[color] || 0, set[color] || 0].max
          end
        end.values.inject(&:*)
      end
    end
  end
end
