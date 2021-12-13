# frozen_string_literal: true

module Day13
  def process_input(str)
    points, instructions = str.split("\n\n").reject(&:empty?)
    points = points.split("\n").reject(&:empty?).map do |l|
      l.split(",").map(&:to_i)
    end
    instructions = instructions.split("\n").reject(&:empty?).map do |l|
      md = l.match(/([xy])=(\d+)/)
      md[1] == "x" ? [md[2].to_i, 0] : [0, md[2].to_i]
    end
    [points, instructions]
  end

  def problem1(input)
    points, instructions = input
    instructions.inject(points) do |prev, coord|
      nxt = prev.each_with_object([]) do |pt, acc|
        index = coord[0].zero? ? 1 : 0
        if pt[index] < coord[index]
          acc.push(pt)
        else
          acc.push(pt.each_with_index.map { |c, i| i == index ? 2 * coord[i] - c : c })
        end
      end
      return nxt.uniq.size
    end
  end

  def problem2(input)
    points, instructions = input
    folded = instructions.inject(points) do |prev, coord|
      nxt = prev.each_with_object([]) do |pt, acc|
        index = coord[0].zero? ? 1 : 0
        if pt[index] < coord[index]
          acc.push(pt)
        else
          acc.push(pt.each_with_index.map { |c, i| i == index ? 2 * coord[i] - c : c })
        end
      end
    end
    (0..folded.map(&:last).max).map do |y|
      (0..folded.map(&:first).max).map do |x|
        (folded.include?([x, y]) ? "#" : ".")
      end.join
    end.join("\n")
  end
end
