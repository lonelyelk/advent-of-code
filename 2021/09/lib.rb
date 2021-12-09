# frozen_string_literal: true

# https://adventofcode.com/2021/day/9
module Day09
  def process_input(str)
    depths = str.chomp.split("\n").reject(&:empty?).map { |l| [10, *l.chars.map(&:to_i), 10] }
    [Array.new(depths.first.size, 10), *depths, Array.new(depths.first.size, 10)]
  end

  def problem1(input)
    points = []
    (1...(input.size - 1)).each do |x|
      (1...(input[x].size - 1)).each do |y|
        if input[x - 1][y] > input[x][y] && input[x + 1][y] > input[x][y] &&
           input[x][y - 1] > input[x][y] && input[x][y + 1] > input[x][y]
          points.push(input[x][y])
        end
      end
    end
    points.inject(&:+) + points.size
  end

  def problem2(input)
    pools = []
    (1...(input.size - 1)).each do |x|
      (1...(input[x].size - 1)).each do |y|
        next unless input[x - 1][y] > input[x][y] && input[x + 1][y] > input[x][y] &&
                    input[x][y - 1] > input[x][y] && input[x][y + 1] > input[x][y]

        pool = low_neighbours([[x, y]], input)
        loop do
          prev_pool = pool
          pool = low_neighbours(pool, input)
          break if pool.difference(prev_pool).empty?
        end
        pools.push pool
      end
    end
    pools.sort_by(&:size)[-3..].inject(1) { |acc, pool| acc * pool.size }
  end

  protected

  def low_neighbours(points, input)
    points.each_with_object([]) do |(x, y), acc|
      acc.push([x, y])
      ([[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]] - points).each do |xx, yy|
        acc.push([xx, yy]) if input[xx][yy] < 9
      end
    end.uniq
  end
end