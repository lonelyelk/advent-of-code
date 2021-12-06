# frozen_string_literal: true

module Day06
  def process_input(str)
    str.chomp.split(",").map(&:to_i)
  end

  def problem1(input)
    (0...80).to_a.inject(input.each_with_object(Hash.new(0)) { |days, acc| acc[days] += 1 }) do |population, _i|
      population.each_with_object(Hash.new(0)) do |(days, count), acc|
        if days == 0
          acc[6] += count
          acc[8] += count
        else
          acc[days-1] += count
        end
      end
    end.values.inject(&:+)
  end

  def problem2(input)
    (0...256).to_a.inject(input.each_with_object(Hash.new(0)) { |days, acc| acc[days] += 1 }) do |population, _i|
      population.each_with_object(Hash.new(0)) do |(days, count), acc|
        if days == 0
          acc[6] += count
          acc[8] += count
        else
          acc[days-1] += count
        end
      end
    end.values.inject(&:+)
  end
end
