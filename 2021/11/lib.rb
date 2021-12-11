# frozen_string_literal: true

# https://adventofcode.com/2021/day/11
module Day11
  def process_input(str)
    str.split("\n").reject(&:empty?).map { |l| l.chars.map(&:to_i) }
  end

  def problem1(input, steps = 100)
    pool = input
    total_flashes = 0
    (0...steps).each do
      pool = basic_step_inc(pool)
      pool, flashes = step_flash(pool)
      total_flashes += flashes.size
      pool = step_flash_reset(pool)
    end
    total_flashes
  end

  def problem2(input)
    pool = input
    (1..).each do |step|
      pool = basic_step_inc(pool)
      pool, = step_flash(pool)
      break step if count_flashes(pool) == 100

      pool = step_flash_reset(pool)
    end
  end

  protected

  def diffs
    d = (-1..1).to_a
    d.inject([]) { |acc, x| acc + d.map { |y| [x, y] } }
  end

  def neighbours(coords)
    res = diffs.each_with_object([]) do |(dx, dy), acc|
      acc.push([coords, [dx, dy]].transpose.map(&:sum))
    end
    res.reject do |c|
      c.any? { |coord| coord.negative? || coord > 9 } || c == coords
    end
  end

  def basic_step_inc(pool)
    pool.map do |line|
      line.map(&:succ)
    end
  end

  def step_flash(pool, flashes = [])
    pool, flashes = sub_step_flash(pool, flashes) while flashes.size < count_flashes(pool)
    [pool, flashes]
  end

  def sub_step_flash(pool, flashes)
    next_pool = pool.map(&:dup)
    next_flashes = flashes.dup
    (0..9).each do |x|
      (0..9).each do |y|
        next unless next_pool[x][y] > 9 && !next_flashes.include?([x, y])

        next_flashes.push([x, y])
        neighbours([x, y]).each { |xx, yy| next_pool[xx][yy] += 1 }
      end
    end
    [next_pool, next_flashes]
  end

  def count_flashes(pool)
    pool.inject(0) { |sum, l| sum + l.count { |c| c > 9 } }
  end

  def step_flash_reset(pool)
    pool.map do |l|
      l.map { |c| c > 9 ? 0 : c }
    end
  end
end
