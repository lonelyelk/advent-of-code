# frozen_string_literal: true

# https://adventofcode.com/2021/day/22
module Day22
  def process_input(str)
    str.split("\n").reject(&:empty?).map do |line|
      md = line.match(/(on|off) x=(-?\d+)..(-?\d+),y=(-?\d+)..(-?\d+),z=(-?\d+)..(-?\d+)/)
      md[2, 6].map(&:to_i).each_slice(2).to_a + [md[1].to_sym]
    end
  end

  def problem1(input)
    problem2(intersections_within([[-50, 50], [-50, 50], [-50, 50]], input))
  end

  def problem2(input)
    intersections = []
    slow = {}
    input.each_with_index.inject(0) do |sum, (cuboid, index)|
      add = cuboid[3] == :on ? volume(cuboid) : 0
      if index != 0
        ints = intersections_within(cuboid, input[0, index]).reject { |int| int[3] == :off }
        ints.each { |int| add -= volume(int) }
        intersections.each_with_index do |intrns, i|
          ints1 = intersections_within(cuboid, intrns)
          ints1.map { |int| volume(int) }.each do |vol|
            add = i.even? ? add + vol : add - vol
          end
          intrns.concat(ints)
          ints = ints1
        end
        intersections.push(ints)
      end
      sum + add
    end
  end

  def intersections_within(cuboid, input)
    input.each_with_object([]) do |cbd, res|
      intersect = (0..2).all? do |i|
        cbd[i][0] <= cuboid[i][1] && cbd[i][1] >= cuboid[i][0]
      end
      next unless intersect

      intrn = (0..2).map do |i|
        [[cbd[i][0], cuboid[i][0]].max, [cbd[i][1], cuboid[i][1]].min]
      end
      intrn.push(cbd[3])
      res.push(intrn)
    end
  end

  def volume(cuboid)
    cuboid[0, 3].map { |c| c[1] - c[0] + 1 }.inject(&:*)
  end
end
