# frozen_string_literal: true

# https://adventofcode.com/2024/day/11
module Year2024
  module Day11
    def process_input(str)
      str.split.each_with_object(Hash.new(0)) do |num, acc|
        acc[num] += 1
      end
    end

    def problem1(input, blinks = 25)
      blinks.times do
        input = input.each_with_object(Hash.new(0)) do |(num, count), acc|
          transform_stone(num).each { |n| acc[n] += count }
        end
      end
      input.values.sum
    end

    def problem2(input)
      problem1(input, 75)
    end

    def transform_stone(num)
      if num == "0"
        ["1"]
      elsif num.size.even?
        [num[...(num.size / 2)].to_i.to_s, num[(num.size / 2)..].to_i.to_s]
      else
        [(num.to_i * 2024).to_s]
      end
    end
  end
end
