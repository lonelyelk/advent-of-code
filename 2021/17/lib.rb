# frozen_string_literal: true

# https://adventofcode.com/2021/day/17
module Day17
  def process_input(str)
    md = str.match(/x=(\d+)\D+(\d+).+y=(-\d+)\D+(-\d+)/)
    { x: [md[1], md[2]].map(&:to_i), y: [md[3], md[4]].map(&:to_i) }
  end

  def problem1(input)
    (-input[:y].min - 1).downto(1).inject(&:+)
  end

  def problem2(input)
    input[:y].min.upto(-input[:y].min - 1).inject(0) do |acc, vy0|
      acc + 1.upto(input[:x].max).count do |vx0|
        solve(vx0, vy0, input)
      end
    end
  end

  protected

  def solve(speed_x, speed_y, input)
    x = y = 0
    while x <= input[:x].max && y >= input[:y].min
      return true if x.between?(*input[:x]) && y.between?(*input[:y])

      x += speed_x
      y += speed_y
      speed_x -= 1 if speed_x.positive?
      speed_y -= 1
    end
    false
  end
end
