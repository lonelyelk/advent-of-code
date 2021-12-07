# frozen_string_literal: true

module Day07
  def process_input(str)
    str.chomp.split(",").map(&:to_i)
  end

  def problem1(input)
    sorted = input.sort
    pos = (sorted[sorted.size / 2] + sorted[(sorted.size - 1) / 2]) / 2
    sorted.inject(0) { |acc, crab| acc + (crab - pos).abs }
  end

  def problem2(input)
  end
end
