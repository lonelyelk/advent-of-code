# frozen_string_literal: true

# https://adventofcode.com/2021/day/3
module Day03
  def process_input(str)
    str.split("\n").reject(&:empty?)
  end

  def gamma_rate(input)
    ones = count_ones(input)
    ones.each_with_index.inject(0) do |res, (bits, index)|
      bit = bits > input.size / 2 ? 1 : 0
      res | (bit << (ones.length - index - 1))
    end
  end

  def problem1(input)
    gamma = gamma_rate(input)
    epsilon = ((2**input.first.size) - 1) ^ gamma
    gamma * epsilon
  end

  def oxygen_rate(input)
    gas_rate(input, %w[0 1])
  end

  def co2_rate(input)
    gas_rate(input, %w[1 0])
  end

  def gas_rate(input, rejection_priority)
    index = 0
    filtered = input.dup
    while filtered.size > 1
      ones = filtered.inject(0) { |cnt, val| cnt + val[index].to_i }
      filtered.reject! do |val|
        val[index] == reject_bit(filtered.size, ones, rejection_priority)
      end
      index += 1
    end
    filtered.first.to_i(2)
  end

  def problem2(input)
    oxygen_rate(input) * co2_rate(input)
  end

  protected

  def count_ones(input)
    input.each_with_object(Array.new(input.first.size, 0)) do |val, counter|
      val.chars.each_with_index { |bit, index| counter[index] += bit.to_i }
    end
  end

  def reject_bit(size, count, rejection_priority)
    half = size / 2
    if size.even? && count == half
      rejection_priority[0]
    else
      count > half ? rejection_priority[0] : rejection_priority[1]
    end
  end
end
