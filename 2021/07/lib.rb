# frozen_string_literal: true

module Day07
  def process_input(str)
    str.chomp.split(",").map(&:to_i)
  end

  def problem1(input)
    sorted = input.sort
    median = (sorted[sorted.size / 2] + sorted[(sorted.size - 1) / 2]) / 2
    sorted.inject(0) { |acc, crab| acc + (crab - median).abs }
  end

  def problem2(input)
    mean = (input.inject(0.0) { |acc, crab| acc + crab} / input.size).round
    possible = ((mean - 3)..(mean + 3)).map { |pos| total_fuel(input, pos) }
    possible.min
  end

  protected

  def total_fuel(input, pos)
    input.inject(0) { |acc, crab| acc + fuel_for((crab - pos).abs) }
  end

  def fuel_for(steps)
    return 0 if steps == 0
    (1..steps).to_a.inject(&:+)
  end
end
