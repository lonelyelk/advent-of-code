# frozen_string_literal: true

# https://adventofcode.com/2021/day/6
module Day06
  def process_input(str)
    str.chomp.split(",").map(&:to_i)
  end

  def problem1(input)
    multiply(initial_population(input), 80)
  end

  def problem2(input)
    multiply(initial_population(input), 256)
  end

  protected

  def initial_population(input)
    input.each_with_object(Hash.new(0)) { |days, acc| acc[days] += 1 }
  end

  def multiply(init_population, total_days)
    (0...total_days).to_a.inject(init_population) { |pop, _i| next_day(pop) }.values.inject(&:+)
  end

  def next_day(population)
    population.each_with_object(Hash.new(0)) do |(days, count), acc|
      if days.zero?
        acc[6] += count
        acc[8] += count
      else
        acc[days - 1] += count
      end
    end
  end
end
