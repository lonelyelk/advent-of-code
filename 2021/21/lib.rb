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
    @count = 0
    @die = (1..100).to_enum
    loop do
      positions, scores = game_move(positions, scores, player, roll_det_3d100)
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
      variant_positions, variant_scores = game_move(positions, scores, player, roll)
      if variant_scores[player] >= 21
        wins.each_with_index.map { |w, i| i == player ? w + count : w }
      else
        cache_key = variant_positions + variant_scores + [player]
        @cache[cache_key] ||= round_dirac(variant_positions, variant_scores, next_player(player))
        wins.zip(@cache[cache_key].map { |w| w * count }).map(&:sum)
      end
    end
  end

  def game_move(positions, scores, player, roll)
    next_positions = positions.dup
    next_scores = scores.dup
    next_positions[player] += roll
    next_positions[player] %= 10
    next_scores[player] += next_positions[player] + 1
    [next_positions, next_scores]
  end
end
