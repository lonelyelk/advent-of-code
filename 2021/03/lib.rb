# frozen_string_literal: true

module Day03
  def process_input(str)
    str.split("\n").reject(&:empty?)
  end

  def gamma_rate(input)
    counts = input.each_with_object(Array.new(input.first.size, 0)) do |val, counter|
      val.chars.each_with_index { |bit, index| counter[index] += bit.to_i }
    end
    counts.each_with_index.inject(0) do |res, (bits, index)|
      bit = bits > input.size / 2 ? 1 : 0
      res |= bit << (counts.length - index - 1)
    end
  end

  def problem1(input)
    gamma = gamma_rate(input)
    epsilon = (2 ** input.first.size - 1) ^ gamma
    gamma * epsilon
  end

  def oxygen_rate(input)
    index = 0
    filtered = input.dup
    while filtered.size > 1
      count = filtered.inject(0) { |cnt, val| cnt += val[index].to_i }
      filtered.reject! do |val|
        half = filtered.size / 2
        reject_bit =
          if filtered.size % 2 == 0 && count == half
            "0"
          elsif count > half
            "0"
          else
            "1"
          end
        val[index] == reject_bit
      end
      index += 1
    end
    filtered.first.to_i(2)
  end

  def co2_rate(input)
    index = 0
    filtered = input.dup
    while filtered.size > 1
      count = filtered.inject(0) { |cnt, val| cnt += val[index].to_i }
      filtered.reject! do |val|
        half = filtered.size / 2
        reject_bit =
          if filtered.size % 2 == 0 && count == half
            "1"
          elsif count > half
            "1"
          else
            "0"
          end
        val[index] == reject_bit
      end
      index += 1
    end
    filtered.first.to_i(2)
  end

  def problem2(input)
    oxygen_rate(input) * co2_rate(input)
  end
end
