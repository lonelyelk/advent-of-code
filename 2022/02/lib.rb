# frozen_string_literal: true

# https://adventofcode.com/2022/day/2
module Year2022
  module Day02
    WIN = 6
    DRAW = 3
    LOSE = 0
    VALUES = {
      rock: 1,
      paper: 2,
      scissors: 3,
    }.freeze
    RULES = {
      rock: {
        rock: DRAW,
        paper: WIN,
        scissors: LOSE,
      },
      paper: {
        rock: LOSE,
        paper: DRAW,
        scissors: WIN,
      },
      scissors: {
        rock: WIN,
        paper: LOSE,
        scissors: DRAW,
      },
    }.freeze
    MAP = {
      "A" => :rock,
      "B" => :paper,
      "C" => :scissors,
      "X" => :rock,
      "Y" => :paper,
      "Z" => :scissors,
    }.freeze
    STRAT = {
      "X" => LOSE,
      "Y" => DRAW,
      "Z" => WIN,
    }.freeze

    def process_input(str)
      str.split("\n").reject(&:empty?).map(&:split)
    end

    def problem1(input)
      input.inject(0) do |acc, round|
        acc + VALUES[MAP[round[1]]] + RULES[MAP[round[0]]][MAP[round[1]]]
      end
    end

    def problem2(input)
      input.inject(0) do |acc, round|
        acc + VALUES[RULES[MAP[round[0]]].key(STRAT[round[1]])] + STRAT[round[1]]
      end
    end
  end
end
