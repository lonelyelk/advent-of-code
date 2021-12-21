# frozen_string_literal: true

# https://adventofcode.com/2021/day/21
module Day21
  def process_input(str)
    str.split("\n").reject(&:empty?).map { |l| l.match(/\d$/)[0].to_i - 1 }
  end

  def problem1(input)
    positions = input.dup
    scores = [0, 0]
    player = 0
    loop do
      positions[player] += roll_det_3d100
      positions[player] %= 10
      scores[player] += positions[player] + 1
      return scores[next_player(player)] * @count if scores[player] >= 1000

      player = next_player(player)
    end
  end

  def problem2(input)
    @cache = {}
    round_dirac(input, [0, 0], 0).max
  end

  protected

  def next_player(player)
    player ^ 1
  end

  def roll_det_3d100
    @count ||= 0
    @die ||= (1..100).to_enum
    (1..3).inject(0) do |acc, _|
      @count += 1
      acc + @die.next
    rescue StopIteration
      @die.rewind
      acc + @die.next
    end
  end

  def roll_dirac
    (1..3).each_with_object([]) do |d1, acc|
      (1..3).each do |d2|
        (1..3).each { |d3| acc.push(d1 + d2 + d3) }
      end
    end
  end

  def round_dirac(positions, scores, player)
    roll_dirac.tally.inject([0, 0]) do |wins, (roll, count)|
      variant_positions = positions.dup
      variant_scores = scores.dup
      variant_positions[player] += roll
      variant_positions[player] %= 10
      variant_scores[player] += variant_positions[player] + 1
      if variant_scores[player] >= 21
        wins.each_with_index.map { |w, i| i == player ? w + count : w }
      else
        cache_key = variant_positions + variant_scores + [player]
        result =
          if @cache[cache_key]
            @cache[cache_key]
          else
            @cache[cache_key] = round_dirac(variant_positions, variant_scores, player ^ 1)
          end
        wins.zip(result.map { |w| w * count }).map(&:sum)
      end
    end
  end
end
