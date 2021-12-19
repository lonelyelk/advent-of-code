# frozen_string_literal: true

# https://adventofcode.com/2021/day/19
module Day19
  def process_input(str)
    str.split(/---[^-]+---/).reject(&:empty?).map do |scanner|
      scanner.chomp.split("\n").reject(&:empty?).map do |l|
        Vector[*l.split(",").map(&:to_i)]
      end
    end
  end

  def problem12(input)
    accounted = { 0 => input[0] }
    used_as_base = {}
    scanners = []
    while accounted.keys.size < input.size
      keys_left = accounted.keys - used_as_base.keys
      raise "Ran out of keys" if keys_left.empty?

      keys_left.each do |base_index|
        (0...input.size).each do |index|
          next if accounted.key?(index)

          p [base_index, index, accounted.keys.size]
          transformation, diff = best_transformation_from(accounted[base_index], input, index)
          if transformation
            accounted[index] = transformation
            scanners.push(diff.to_a)
          end
        end
        used_as_base[base_index] = true
      end
    end
    beacons = accounted.values.flatten.uniq
    max_distance = (0...(scanners.size - 1)).inject(0) do |acc, i|
      ((i+1)...scanners.size).inject(acc) do |m, j|
        distance = (0..2).map { |n| (scanners[i][n] - scanners[j][n]).abs }.inject(&:+)
        distance > m ? distance : m
      end
    end
    [beacons.size, max_distance]
  end

  def rotation_matrices
    @matrices ||= [1, -1].each_with_object([]) do |c0, acc|
      (0..2).each do |i|
        column0 = Array.new(3, 0)
        column0[i] = c0
        [1, -1].each do |c1|
          ((0..2).to_a - [i]).each do |j|
            column1 = Array.new(3, 0)
            column1[j] = c1
            [1, -1].each do |c2|
              k = ((0..2).to_a - [i, j]).first
              column2 = Array.new(3, 0)
              column2[k] = c2
              acc.push(::Matrix.columns([column0, column1, column2]))
            end
          end
        end
      end
    end.reject { |m| m.determinant < 0 }
  end

  def rotation(input, index, nr)
    @rotation_cache ||= {}
    key = "#{index},#{nr}"
    @rotation_cache[key] ||= input[index].map { |coord| rotation_matrices[nr] * coord }
  end

  def best_transformation_from(base_scanner, input, index)
    (0...24).each do |r|
      rotated = rotation(input, index, r)
      (0..(rotated.size - 12)).each do |i|
        transformed = {}
        base_scanner.each do |coord0|
          diff = coord0 - rotated[i]
          next if transformed.key?(diff.to_s)

          transformed[diff.to_s] = rotated.map { |c| c + diff }
          intersection = base_scanner.intersection(transformed[diff.to_s]).size
          return [transformed[diff.to_s], diff] if intersection >= 12
        end
      end
    end
    [nil, nil]
  end
end
