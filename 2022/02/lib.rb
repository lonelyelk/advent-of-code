# frozen_string_literal: true

# https://adventofcode.com/2022/day/2
module Year2022
  VALUES = {
    rock: 1,
    paper: 2,
    scissors: 3,
  }.freeze
  RULES = {
    rock: {
      rock: 3,
      paper: 6,
      scissors: 0,
    },
    paper: {
      rock: 0,
      paper: 3,
      scissors: 6,
    },
    scissors: {
      rock: 6,
      paper: 0,
      scissors: 3,
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
    "X" => 0,
    "Y" => 3,
    "Z" => 6,
  }.freeze
  module Day02
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
