# frozen_string_literal: true

# https://adventofcode.com/2021/day/8
module Day08
  LETTERS = "abcdefg".chars.freeze
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
      number = line.last.map do |repr|
        mapped = repr.chars.map { |c| dict[c] }
        DIGITS.keys.detect { |d| DIGITS[d].size == mapped.size && DIGITS[d].difference(mapped).empty? }
      end
      sum + number.join.to_i
    end
  end

  protected

  def segment_frequency(all_digits)
    all_digits.each_with_object(Hash.new(0)) { |repr, acc| repr.chars.each { |letter| acc[letter] += 1 } }
  end

  def build_dict(signals)
    frequency = segment_frequency(signals)
    dict = FREQUENCY.each_with_object({}) { |(letter, freq), acc| acc[frequency.key(freq)] = [letter] }
    signals.each_with_object(dict) do |digit_repr, dict|
      possible_letters = DIGITS.inject([]) { |acc, (_d, l)| l.size == digit_repr.size ? acc + l : acc }
      repr_chars = digit_repr.chars
      next if repr_chars.any? { |l| dict[l] && !dict[l].intersect?(possible_letters) }

      repr_chars.each do |l|
        dict[l] = if dict[l]
                    dict[l].intersection(possible_letters)
                  else
                    possible_letters
                  end
      end
    end
  end

  def deduce(dict)
    while dict.values.any? { |v| v.size > 1 }
      dict = dict.transform_values do |vals|
        if vals.size == 1
          vals
        else
          dict.values.inject(vals) { |a, v| v.size == 1 ? a - v : a }
        end
      end
    end
    dict.transform_values(&:first)
  end
end
