# frozen_string_literal: true

# https://adventofcode.com/2021/day/15
module Day15
  def process_input(str)
    str.split("\n").reject(&:empty?).map { |l| l.chars.map(&:to_i) }
  end

  def problem1(input)
    total_risk = init_total_risk(input)
    to_update = [[0, 0]]
    until to_update.empty?
      to_update = to_update.inject([]) do |acc, (x, y)|
        acc + update_neighbours(x, y, input, total_risk)
      end
    end

    total_risk[input.size - 1][input.first.size - 1]
  end

  # it takes 1m 3s to finish, but I refuse to refactor it for now
  def problem2(input)
    real_input = input.map do |l|
      (0...5).to_a.inject([]) do |acc, i|
        acc + rotate_line(l, i)
      end
    end
    real_input = (0...5).to_a.inject([]) do |acc, i|
      acc + real_input.map { |l| rotate_line(l, i) }
    end
    problem1(real_input)
  end

  protected

  def init_total_risk(input)
    total_risk = Array.new(input.size) do |i|
      Array.new(input[i].size, Float::INFINITY)
    end
    total_risk[0][0] = 0
    total_risk
  end

  # rubocop:disable Naming/MethodParameterName
  def out_of_bounds?(x, y, field)
    x.negative? || y.negative? || x >= field.size || y >= field.first.size
  end

  def neighbours(x, y, field)
    [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y]].reject { |xx, yy| out_of_bounds?(xx, yy, field) }
  end

  def update_neighbours(x, y, risk, total_risk)
    neighbours(x, y, risk).each_with_object([]) do |(xx, yy), to_update|
      potential = total_risk[x][y] + risk[xx][yy]
      next if total_risk[xx][yy] <= potential

      total_risk[xx][yy] = potential
      to_update.push([xx, yy])
    end
  end
  # rubocop:enable Naming/MethodParameterName

  def rotate_line(line, offset)
    line.map do |num|
      next_num = num + offset
      next_num -= 9 if next_num > 9
      next_num
    end
  end
end
