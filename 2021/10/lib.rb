# frozen_string_literal: true

module Day10
  PARENS = {
    "(" => ")",
    "{" => "}",
    "[" => "]",
    "<" => ">",
  }
  ILLEGAL_SCORES = {
    "" => 0,
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137,
  }
  AUTOCOMPLETE_SCORES = {
    "" => 0,
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4,
  }
  def process_input(str)
    str.split("\n").reject(&:empty?)
  end

  def problem1(input)
    input.inject(0) do |score, line|
      illegal = parse(line)[:illegal]
      score + ILLEGAL_SCORES[illegal]
    end
  end

  def problem2(input)
    scores = input.filter_map do |line|
      parsed = parse(line)
      next unless parsed[:illegal].empty?

      parsed[:stack].reverse.inject(0) { |sum, char| sum * 5 + AUTOCOMPLETE_SCORES[char] }
    end
    scores.sort[scores.size / 2]
  end

  protected

  def parse(line)
    line.chars.each_with_object({ stack: [], illegal: "" }) do |char, acc|
      if PARENS.key?(char)
        acc[:stack].push(PARENS[char])
      elsif acc[:stack].last == char
        acc[:stack].pop
      else
        acc[:illegal] = char
        break acc
      end
    end
  end
end
