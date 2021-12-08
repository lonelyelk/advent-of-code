# frozen_string_literal: true

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

  def process_input(str)
    str.split("\n").reject(&:empty?).map { |l| l.split(/\s+\|\s+/).map(&:split) }
  end

  def problem1(input)
    input.inject(0) { |acc, line| acc + line[1].count { |digit| [2, 3, 4, 7].include?(digit.size) } }
  end

  def problem2(input)
    frequency = DIGITS.each_with_object(Hash.new(0)) { |(_, l), acc| l.each { |l| acc[l] += 1 } }
    unique_frequency = frequency.reject { |_, l| frequency.values.count(l) > 1 }
    input.inject(0) do |sum, line|
      scrabled_frequency = line.first.each_with_object(Hash.new(0)) { |repr, acc| repr.chars.each { |l| acc[l] += 1 } }
      dict = unique_frequency.each_with_object({}) { |(letter, freq), acc| acc[scrabled_frequency.key(freq)] = [letter] }
      dict = line.first.each_with_object(dict) do |digit_repr, dict|
        possible_letters = DIGITS.inject([]) { |acc, (_d, l)| l.size == digit_repr.size ? acc + l : acc }
        repr_chars = digit_repr.chars
        next if repr_chars.any? { |l| dict[l] && !dict[l].intersect?(possible_letters) }
        repr_chars.each do |l|
          if dict[l]
            dict[l] = dict[l].intersection(possible_letters)
          else
            dict[l] = possible_letters
          end
        end
      end
      while dict.values.any? { |v| v.size > 1 }
        dict = dict.each_with_object({}) do |(letter, vals), acc|
          if vals.size == 1
            acc[letter] = vals
          else
            acc[letter] = dict.values.inject(vals) { |a, v| v.size == 1 ? a - v : a }
          end
        end
      end
      dict = dict.each_with_object({}) { |(letter, vals), acc| acc[letter] = vals.first }
      number = line.last.map do |repr|
        mapped = repr.chars.map { |c| dict[c] }
        DIGITS.keys.detect { |d| DIGITS[d].size == mapped.size && DIGITS[d].difference(mapped).empty? }
      end
      sum + number.join.to_i
    end
  end
end
