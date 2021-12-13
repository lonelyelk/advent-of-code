# frozen_string_literal: true

# https://adventofcode.com/2021/day/13
module Day13
  def process_input(str)
    points_input, instructions_input = str.split("\n\n").reject(&:empty?)
    [process_points(points_input), process_instructions(instructions_input)]
  end

  def problem1(input)
    points, instructions = input
    fold_over(points, instructions.first).size
  end

  def problem2(input)
    points, instructions = input
    folded = instructions.inject(points) do |prev, coord|
      fold_over(prev, coord)
    end
    (0..folded.map(&:last).max).map do |y|
      (0..folded.map(&:first).max).map do |x|
        (folded.include?([x, y]) ? "#" : ".")
      end.join
    end.join("\n")
  end

  protected

  def process_points(input)
    input.split("\n").reject(&:empty?).map do |l|
      l.split(",").map(&:to_i)
    end
  end

  def process_instructions(input)
    input.split("\n").reject(&:empty?).map do |l|
      md = l.match(/([xy])=(\d+)/)
      md[1] == "x" ? [md[2].to_i, 0] : [0, md[2].to_i]
    end
  end

  def fold_over(points, coord)
    nxt = points.each_with_object([]) do |pt, acc|
      index = coord[0].zero? ? 1 : 0
      if pt[index] < coord[index]
        acc.push(pt)
      else
        acc.push(pt.each_with_index.map { |c, i| i == index ? (2 * coord[i]) - c : c })
      end
    end
    nxt.uniq
  end
end
