# frozen_string_literal: true

# https://adventofcode.com/2021/day/8
module Day08
  SEGMENTS = "abcdefg".chars.freeze
  DIGITS = {
    0 => "abcefg".chars.freeze,
    1 => "cf".chars.freeze,
    2 => "acdeg".chars.freeze,
    3 => "acdfg".chars.freeze,
    4 => "bcdf".chars.freeze,
    5 => "abdfg".chars.freeze,
    6 => "abdefg".chars.freeze,
    7 => "acf".chars.freeze,
    8 => "abcdefg".chars.freeze,
    9 => "abcdfg".chars.freeze,
  }.freeze
  FREQUENCY = {
    "e" => 4,
    "b" => 6,
    "f" => 9,
  }.freeze

  def process_input(str)
    str.split("\n").reject(&:empty?).map { |l| l.split(/\s+\|\s+/).map(&:split) }
  end

  def problem1(input)
    input.inject(0) { |acc, line| acc + line[1].count { |digit| [2, 3, 4, 7].include?(digit.size) } }
  end

  def problem2(input)
    input.inject(0) do |sum, line|
      dict = build_dict(line.first)
      dict = deduce(dict)
      number = convert_to_number(line.last, dict)
      sum + number
    end
  end

  protected

  def segment_frequency(all_digits)
    all_digits.each_with_object(Hash.new(0)) { |repr, acc| repr.chars.each { |segment| acc[segment] += 1 } }
  end

  def build_dict(signals)
    signals.each_with_object(init_dict(signals)) do |digit_repr, dict|
      representation = digit_repr.chars
      possible_segments = possible_segments_from_size(representation)
      next if representation.any? { |l| !dict[l].intersect?(possible_segments) }

      representation.each { |l| dict[l] = dict[l].intersection(possible_segments) }
    end
  end

  def init_dict(signals)
    frequency = segment_frequency(signals)
    dict = FREQUENCY.each_with_object({}) { |(segment, freq), acc| acc[frequency.key(freq)] = [segment] }
    SEGMENTS.each_with_object(dict) { |segment, acc| acc[segment] ||= SEGMENTS.dup }
  end

  def possible_segments_from_size(representation)
    DIGITS.inject([]) { |acc, (_d, l)| l.size == representation.size ? acc + l : acc }
  end

  def deduce(dict)
    while dict.values.any? { |segments| segments.size > 1 }
      dict = dict.transform_values do |segments|
        segments.size == 1 ? segments : remove_certain(segments, dict)
      end
    end
    dict.transform_values(&:first)
  end

  def remove_certain(values, dict)
    dict.values.inject(values) { |acc, vals| vals.size == 1 ? acc - vals : acc }
  end

  def convert_to_number(signals, dict)
    signals.map do |repr|
      mapped = repr.chars.map { |c| dict[c] }
      DIGITS.keys.detect { |d| DIGITS[d].size == mapped.size && DIGITS[d].difference(mapped).empty? }
    end.join.to_i
  end
end
