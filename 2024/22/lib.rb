# frozen_string_literal: true

# https://adventofcode.com/2024/day/22
module Year2024
  module Day22
    def process_input(str)
      str.split("\n").map(&:to_i)
    end

    def problem1(input)
      input.sum do |num|
        2000.times do
          num = prune(mix(num, num * 64))
          num = prune(mix(num, num / 32))
          num = prune(mix(num, num * 2048))
        end
        num
      end
    end

    def problem2(input)
      market = input.map do |num|
        key = []
        2000.times.each_with_object({}) do |_, acc|
          price = num % 10
          acc[key.to_s] ||= price if key.size == 4
          num = prune(mix(num, num * 64))
          num = prune(mix(num, num / 32))
          num = prune(mix(num, num * 2048))
          nprice = num % 10
          key.push(nprice - price)
          key.shift if key.size > 4
        end
      end
      res = market.each_with_object(Hash.new(0)) do |buyer, acc|
        buyer.each do |seq, bananas|
          acc[seq] += bananas
        end
      end
      res.values.max
    end

    def mix(num, other)
      num ^ other
    end

    def prune(num)
      num % 16_777_216
    end
  end
end
