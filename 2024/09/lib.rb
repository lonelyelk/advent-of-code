# frozen_string_literal: true

# https://adventofcode.com/2024/day/9
module Year2024
  module Day09
    def process_input(str)
      str.chomp
    end

    # rubocop:disable Metrics/MethodLength
    def problem1(input)
      drive = sectors(input)
      back = drive.size
      sum = 0
      (0..).each do |pos|
        back -= 1 while back > pos && !drive[back]
        if drive[pos]
          sum += drive[pos] * pos
        else
          sum += drive[back] * pos
          back -= 1
        end
        break if back == pos
      end
      sum
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    def problem2(input)
      drive = partitions(input)
      (input.size / 2).downto(1) do |i|
        size, position = drive[:files][i]

        candidates = drive[:free].select do |space, positions|
          space >= size && !positions.empty? && positions.first < position
        end
        next if candidates.empty?

        space, positions = candidates.min_by { |_, v| v.first }
        new_pos = positions.shift
        remains = space - size
        drive[:files][i] = [size, new_pos]
        drive[:free][remains] = (drive[:free][remains] + [new_pos + size]).sort
      end
      drive[:files].sum do |i, (size, pos)|
        size.times.sum { |j| i * (pos + j) }
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity

    def sectors(input)
      input.chars.each_slice(2).with_index.each_with_object([]) do |((file, space), i), acc|
        acc.push(*Array.new(file.to_i, i))
        acc.push(*Array.new(space.to_i, nil))
      end
    end

    # rubocop:disable Metrics/AbcSize
    def partitions(input)
      position = 0
      input.chars.map(&:to_i).each_slice(2).with_index
           .each_with_object({ files: {}, free: {} }) do |((file, space), i), acc|
        acc[:files][i] = [file, position]
        next if space.nil?

        acc[:free][space] ||= []
        acc[:free][space].push(position + file)
        position += file + space
      end
    end
    # rubocop:enable Metrics/AbcSize
  end
end
