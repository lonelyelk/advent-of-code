# frozen_string_literal: true

# https://adventofcode.com/2021/day/15
module Day15
  def process_input(str)
    str.split("\n").reject(&:empty?).map { |l| l.chars.map(&:to_i) }
  end

  def problem1(input)
    total_risk = Array.new(input.size) do |i|
      Array.new(input[i].size, Float::INFINITY)
    end
    total_risk[0][0] = 0
    to_update = [[0, 0]]
    while !to_update.empty?
      to_update = to_update.inject([]) do |acc, (x, y)|
        acc + update_neighbours(x, y, input, total_risk)
      end
    end
    
    total_risk[input.size - 1][input.first.size - 1]
  end

  def problem2(input)
    real_input = input.map do |l|
      (0...5).to_a.inject([]) do |acc, i|
        acc + l.map do |n|
          n_n = n + i
          n_n -= 9 if n_n > 9
          n_n
        end
      end
    end
    real_input = (0...5).to_a.inject([]) do |acc, i|
      acc + real_input.map do |l|
        l.map do |n|
          n_n = n + i
          n_n -= 9 if n_n > 9
          n_n
        end
      end
    end
    problem1(real_input)
  end

  protected

  def update_neighbours(x, y, risk, total_risk)
    to_update = []
    [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y]].each do |xx, yy|
      next if xx < 0 || yy < 0 || xx >= risk.size || yy >= risk.first.size
      next if total_risk[xx][yy] <= total_risk[x][y] + risk[xx][yy]

      total_risk[xx][yy] = total_risk[x][y] + risk[xx][yy]
      to_update.push([xx, yy])
    end
    to_update
  end
end
