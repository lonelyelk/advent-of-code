# frozen_string_literal: true

# https://adventofcode.com/2021/day/20
module Day20
  def process_input(str)
    alg, pic_repr = str.split("\n\n").map(&:chomp)
    pic = Hash.new(0)
    pic_repr.split("\n").each_with_index do |line, y|
      line.chars.each_with_index do |c, x|
        pic[pt(x, y)] = 1 if c == "#"
      end
    end
    [alg, pic]
  end

  def problem1(input)
    alg, pic = input
    2.times do |i|
      pic = step(default_value(i, alg), alg, pic)
    end
    pic.values.inject(&:+)
  end

  def problem2(input)
    alg, pic = input
    50.times do |i|
      pic = step(default_value(i, alg), alg, pic)
    end
    pic.values.inject(&:+)
  end

  protected

  # rubocop:disable Naming/MethodParameterName
  def pt(x, y)
    x + (y * 1i)
  end
  # rubocop:enable Naming/MethodParameterName

  def neighbours(point)
    [-1i, 0i, 1i].each_with_object([]) do |dy, acc|
      (-1..1).each do |dx|
        acc.push(point + dx + dy)
      end
    end
  end

  def default_value(cycle, alg)
    if alg[0] == "."
      0
    else
      cycle.even? ? 1 : 0
    end
  end

  def step(def_val, alg, pic)
    x_min, x_max = pic.keys.map(&:real).minmax
    y_min, y_max = pic.keys.map(&:imaginary).minmax
    next_pic = Hash.new(def_val)
    ((x_min - 1)..(x_max + 1)).each do |x|
      ((y_min - 1)..(y_max + 1)).each do |y|
        point = pt(x, y)
        pixel = neighbours(point).map { |c| pic[c].to_s }.join.to_i(2)
        next_pic[point] = alg[pixel] == "#" ? 1 : 0
      end
    end
    next_pic
  end
end
