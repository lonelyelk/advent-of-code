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
    count = 0
    input[:y].min.upto(-input[:y].min - 1).each do |vy0|
      1.upto(input[:x].max).each do |vx0|
        x = y = 0
        vx = vx0
        vy = vy0
        hit = false
        while !hit && x <= input[:x].max && y >= input[:y].min
          if x.between?(*input[:x]) && y.between?(*input[:y])
            hit = true
            count += 1
          else
            x += vx
            y += vy
            vx -= 1 if vx > 0
            vy -= 1
          end
        end
      end
    end
    count
  end
end
