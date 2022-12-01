# frozen_string_literal: true

# https://adventofcode.com/2022/day/1
module Day01
  def process_input(str)
    str.split("\n\n").reject(&:empty?).map { |one| one.split("\n").reject(&:empty?).map(&:to_i) }
  end

  def problem1(input)
    input.map(&:sum).max
  end

  def problem2(input)
    input.map(&:sum).sort[-3..].sum
  end
end
