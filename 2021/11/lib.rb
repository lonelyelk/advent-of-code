# frozen_string_literal: true

# https://adventofcode.com/2021/day/11
module Day11
  def process_input(str)
    str.split("\n").reject(&:empty?).map { |l| l.chars.map(&:to_i) }
  end

  def problem1(input, steps=100)
    pool = input
    total_flashes = 0
    (0...steps).each do
      pool = pool.map do |line|
        line.map(&:succ)
      end
      flashes = []
      while flashes.size < pool.inject(0) { |sum, l| sum + l.count { |c| c > 9 } }
        (0..9).each do |x|
          (0..9).each do |y|
            if pool[x][y] > 9 && !flashes.include?([x, y])
              flashes.push([x, y])
              neighbours([x, y]).each do |xx, yy|
                pool[xx][yy] += 1
              end
            end
          end
        end
      end
      total_flashes += flashes.size
      (0..9).each do |x|
        (0..9).each do |y|
          pool[x][y] = 0 if pool[x][y] > 9
        end
      end
    end
    total_flashes
  end

  def problem2(input)
    pool = input
    (1..).each do |step|
      pool = pool.map do |line|
        line.map(&:succ)
      end
      flashes = []
      while flashes.size < pool.inject(0) { |sum, l| sum + l.count { |c| c > 9 } }
        (0..9).each do |x|
          (0..9).each do |y|
            if pool[x][y] > 9 && !flashes.include?([x, y])
              flashes.push([x, y])
              neighbours([x, y]).each do |xx, yy|
                pool[xx][yy] += 1
              end
            end
          end
        end
      end
      break step if pool.all? { |l| l.all? { |c| c > 9 } }
      (0..9).each do |x|
        (0..9).each do |y|
          pool[x][y] = 0 if pool[x][y] > 9
        end
      end
    end
  end

  protected

  def neighbours(coords)
    res = []
    (-1..1).each do |dx|
      (-1..1).each do |dy|
        res.push([coords, [dx, dy]].transpose.map(&:sum))
      end
    end
    res.reject do |c|
      c.any? { |coord| coord.negative? || coord > 9 } || c == coords
    end
  end
end
