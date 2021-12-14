# frozen_string_literal: true

# https://adventofcode.com/2021/day/14
module Day14
  def process_input(str)
    template, rules = str.split("\n\n").reject(&:empty?)
    [template, rules.split("\n").reject(&:empty?).map { |l| l.split(" -> ") }.to_h]
  end

  def problem1(input)
    template, rules = input
    start = build_linked_list(template)
    10.times do
      linked_list_step(start, rules)
    end
    values = count_linked_list_elements(start)
    values.max - values.min
  end

  def problem2(input)
    template, rules = input
    pair_tally = build_pair_tally(template)
    40.times do
      pair_tally = pair_tally_step(pair_tally, rules)
    end
    values = count_pair_tally_elements(pair_tally, template)
    values.max - values.min
  end

  protected

  def build_linked_list(template)
    list_start = {}
    # rubocop:disable Lint/UnmodifiedReduceAccumulator
    template.chars.inject(list_start) do |acc, c|
      acc[:c] = c
      acc[:next] = {}
    end
    # rubocop:enable Lint/UnmodifiedReduceAccumulator
    list_start
  end

  def linked_list_step(cursor, rules)
    while cursor[:next] && cursor[:next][:c]
      insert = rules[cursor[:c] + cursor[:next][:c]]
      cursor[:next] = { c: insert, next: cursor[:next] }
      cursor = cursor[:next][:next]
    end
  end

  def count_linked_list_elements(cursor)
    tally = Hash.new(0)
    while cursor[:next]
      tally[cursor[:c]] += 1
      cursor = cursor[:next]
    end
    tally.values
  end

  def build_pair_tally(template)
    tally = Hash.new(0)
    template.chars.each_cons(2) do |pair_chars|
      tally[pair_chars.join] = 1
    end
    tally
  end

  def pair_tally_step(tally, rules)
    tally.each_with_object(Hash.new(0)) do |(pair, count), acc|
      insert = rules[pair]
      first, last = pair.chars
      acc[first + insert] += count
      acc[insert + last] += count
    end
  end

  def count_pair_tally_elements(pair_tally, template)
    tally = pair_tally.each_with_object(Hash.new(0)) do |(pair, count), acc|
      pair.chars.each { |c| acc[c] += count }
    end
    tally[template.chars.first] += 1
    tally[template.chars.last] += 1
    tally.values.map { |v| v / 2 }
  end
end
