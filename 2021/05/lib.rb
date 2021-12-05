# frozen_string_literal: true

# https://adventofcode.com/2021/day/5
module Day05
  def process_input(str)
    str.split("\n").reject(&:empty?).map { |l| l.split(/\D+/).map(&:to_i) }
  end

  def problem1(input)
    count_dangerous_vents(input.each_with_object(Hash.new(0)) do |coords, acc|
      x1, y1, x2, y2 = *coords
      if x1 == x2
        to_range_array(y1, y2).each { |y| acc["#{x1},#{y}"] += 1 }
      elsif y1 == y2
        to_range_array(x1, x2).each { |x| acc["#{x},#{y1}"] += 1 }
      end
    end)
  end

  def problem2(input)
    count_dangerous_vents(input.each_with_object(Hash.new(0)) do |coords, acc|
      to_coords_range_array(coords).each { |cs| acc["#{cs[0]},#{cs[1]}"] += 1 }
    end)
  end

  protected

  def to_range_array(coord1, coord2)
    if coord1 < coord2
      coord1.upto(coord2)
    else
      coord1.downto(coord2)
    end
  end

  def to_coords_range_array(coords)
    x1, y1, x2, y2 = *coords
    ranges = [[x1, x2], [y1, y2]].map { |cs| to_range_array(*cs).to_a }
    size = ranges.map(&:size).max
    ranges.map { |r| r.size == 1 ? r * size : r }.inject(&:zip)
  end

  def count_dangerous_vents(vents)
    vents.count { |_k, v| v > 1 }
  end
end
