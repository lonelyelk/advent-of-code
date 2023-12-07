# frozen_string_literal: true

# https://adventofcode.com/2023/day/7
module Year2023
  module Day07
    CARDS = {
      "2" => 1,
      "3" => 2,
      "4" => 3,
      "5" => 4,
      "6" => 5,
      "7" => 6,
      "8" => 7,
      "9" => 8,
      "T" => 9,
      "J" => 10,
      "Q" => 11,
      "K" => 12,
      "A" => 13,
    }.freeze

    def process_input(str)
      str.split("\n").reject(&:empty?).map do |line|
        cards, bet = line.split
        [cards, bet.to_i]
      end
    end

    def problem1(input)
      sorted = input.sort do |(cards1, _bet1), (cards2, _bet2)|
        cmp_type = type(cards1) <=> type(cards2)
        if cmp_type.zero?
          cmp_card = cards1.chars.zip(cards2.chars).map { |c1, c2| CARDS[c1] <=> CARDS[c2] }
          cmp_card.detect { |cmp| !cmp.zero? }
        else
          cmp_type
        end
      end
      sorted.each_with_index.inject(0) do |acc, ((_cards, bet), index)|
        acc + bet * (index + 1)
      end
    end

    def problem2(input)
      sorted = input.sort do |(cards1, _bet1), (cards2, _bet2)|
        cmp_type = type_j(cards1) <=> type_j(cards2)
        if cmp_type.zero?
          cmp_card = cards1.chars.zip(cards2.chars).map { |c1, c2| value(c1) <=> value(c2) }
          cmp_card.detect { |cmp| !cmp.zero? }
        else
          cmp_type
        end
      end
      sorted.each_with_index.inject(0) do |acc, ((_cards, bet), index)|
        acc + bet * (index + 1)
      end
    end

    private

    def type(cards)
      case cards.chars.tally.values.sort
      in [5]
        7
      in [*, 4]
        6
      in [2, 3]
        5
      in [*, 3]
        4
      in [*, 2, 2]
        3
      in [*, 2]
        2
      else
        1
      end
    end

    def value(card)
      card == "J" ? 0 : CARDS[card]
    end

    def type_j(cards)
      default_type = type(cards)
      return default_type if !cards.include?("J") || default_type == 7

      substitutes = cards.chars.uniq.reject { |c| c == "J" }
      substitutes.map { |c| type_j(cards.sub("J", c)) }.max
    end
  end
end
