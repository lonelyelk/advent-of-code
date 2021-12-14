# frozen_string_literal: true

# https://adventofcode.com/2021/day/14
module Day14
  def process_input(str)
    template, rules = str.split("\n\n").reject(&:empty?)
    [template, rules.split("\n").reject(&:empty?).map { |l| l.split(" -> ") }.to_h]
  end

  def problem1(input)
    template, rules = input
    start = {}
    template.chars.inject(start) do |acc, c|
      acc[:c] = c
      acc[:next] = {}
    end
    10.times do
      cursor = start
      while cursor[:next] && cursor[:next][:c]
        insert = rules[cursor[:c] + cursor[:next][:c]]
        cursor[:next] = { c: insert, next: cursor[:next] }
        cursor = cursor[:next][:next]
      end
    end
    cursor = start
    tally = Hash.new(0)
    while cursor[:next]
      tally[cursor[:c]] += 1
      cursor = cursor[:next]
    end
    tally.values.max - tally.values.min
  end

  def problem2(input)
    template, rules = input
    counter = Hash.new(0)
    template.chars.each_cons(2) do |pair_chars|
      counter[pair_chars.join] = 1
    end
    40.times do
      counter = counter.each_with_object(Hash.new(0)) do |(pair, count), acc|
        insert = rules[pair]
        first, last = pair.chars
        acc[first + insert] += count
        acc[insert + last] += count
      end
    end
    counter = counter.each_with_object(Hash.new(0)) do |(pair, count), acc|
      pair.chars.each { |c| acc[c] += count }
    end
    counter[template.chars.first] += 1
    counter[template.chars.last] += 1
    (counter.values.max - counter.values.min) / 2
  end
end
