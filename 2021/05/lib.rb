# frozen_string_literal: true

module Day05
  def process_input(str)
    str.split("\n").reject(&:empty?).map { |l| l.split(/\D+/).map(&:to_i) }
  end

  def problem1(input)
    vents = input.each_with_object(Hash.new(0)) do |coords, acc|
      x1, y1, x2, y2 = *coords
      if x1 != x2
        next if y1 != y2
        ([x1, x2].min..[x1, x2].max).each { |x| acc["#{x},#{y1}"] += 1 }
      else
        ([y1, y2].min..[y1, y2].max).each { |y| acc["#{x1},#{y}"] += 1 }
      end
    end
    vents.values.count { |v| v > 1 }
  end

  def problem2(input)
  end
end
