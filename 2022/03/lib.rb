# frozen_string_literal: true

# https://adventofcode.com/2022/day/3
module Year2022
  module Day03
    def process_input(str)
      str.split("\n").reject(&:empty?)
    end

    def problem1(input)
      input.inject(0) do |acc, items|
        compartment1, compartment2 = compartments(items)
        duplicate = compartment1.detect { |c| compartment2.include?(c) }
        duplicate.nil? ? acc : acc + priority(duplicate)
      end
    end

    def problem2(input)
      groups(input).inject(0) do |acc, slice|
        badge = slice.first.detect { |c| slice[1..].all? { |l| l.include?(c) } }
        acc + priority(badge)
      end
    end

    def priority(item)
      @list ||= [*?a..?z, *?A..?Z]
      @list.index(item) + 1
    end

    def compartments(items)
      [
        items.chars[...(items.size / 2)].uniq,
        items.chars[(items.size / 2)..].uniq,
      ]
    end

    def groups(input)
      input.map { |l| l.chars.uniq.sort }.each_slice(3)
    end
  end
end
