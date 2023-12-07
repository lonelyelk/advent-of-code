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
        cmp_type.zero? ? compare_by_value(cards1, cards2) { |c| CARDS[c] } : cmp_type
      end
      winnings(sorted)
    end

    def problem2(input)
      sorted = input.sort do |(cards1, _bet1), (cards2, _bet2)|
        cmp_type = type_j(cards1) <=> type_j(cards2)
        cmp_type.zero? ? compare_by_value(cards1, cards2) { |c| value_j(c) } : cmp_type
      end
      winnings(sorted)
    end

    private

    # Comparing 50000, 41000, 32000, 31100 and so on makes for a compact method whereas pattern
    # matching makes rubobop unhappy about method length.
    def type(cards)
      "#{cards.chars.tally.values.sort.reverse.join}0000"[..4].to_i
    end

    def compare_by_value(cards1, cards2)
      cmp_card = cards1.chars.zip(cards2.chars).map do |c1, c2|
        yield(c1) <=> yield(c2)
      end
      cmp_card.detect { |cmp| !cmp.zero? }
    end

    def winnings(sorted)
      sorted.each_with_index.sum do |(_, bet), index|
        bet * (index + 1)
      end
    end

    def value_j(card)
      card == "J" ? 0 : CARDS[card]
    end

    def type_j(cards)
      default_type = type(cards)
      return default_type if !cards.include?("J") || cards == "JJJJJ"

      substitutes = cards.chars.uniq.reject { |c| c == "J" }
      substitutes.map { |c| type_j(cards.sub("J", c)) }.max
    end
  end
end
