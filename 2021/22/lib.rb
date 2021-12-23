# frozen_string_literal: true

module Day22
  def process_input(str)
    str.split("\n").reject(&:empty?).map do |line|
      md = line.match(/(on|off) x=(-?\d+)..(-?\d+),y=(-?\d+)..(-?\d+),z=(-?\d+)..(-?\d+)/)
      md[2, 6].map(&:to_i).each_slice(2).to_a + [md[1].to_sym]
    end
  end

  def problem1(input)
    space = input.each_with_object({}) do |cuboid, acc|
      Range.new(*cuboid[0]).to_a.intersection((-50..50).to_a).each do |x|
        Range.new(*cuboid[1]).to_a.intersection((-50..50).to_a).each do |y|
          Range.new(*cuboid[2]).to_a.intersection((-50..50).to_a).each do |z|
            acc[[x, y, z]] = cuboid[3]
          end
        end
      end
    end
    space.values.count(:on)
  end

  def problem2(input)
  end

  def cube_intersection(cube1, cube2)
  end
end
