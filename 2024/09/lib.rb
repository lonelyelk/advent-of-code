# frozen_string_literal: true

# https://adventofcode.com/2024/day/9
module Year2024
  module Day09
    def process_input(str)
      str.chomp
    end

    def problem1(input)
      drive = sectors(input)
      back = drive.size - 1
      pos = 0
      sum = 0
      loop do
        if drive[pos]
          sum += drive[pos] * pos
        else
          sum += drive[back] * pos
          back -= 1
        end
        pos += 1
        back -= 1 while back > pos && !drive[back]
        if back <= pos
          sum += drive[pos] * pos
          break
        end
      end
      sum
    end

    def problem2(input)
      drive = partitions(input)
      (input.size / 2).downto(1) do |i|
        size, pos = drive[:files][i]

        new_pos_size = drive[:free].keys.select { |s| s >= size }.min_by { |s| drive[:free][s].first || input.size }
        next if new_pos_size.nil? || drive[:free][new_pos_size].empty? || drive[:free][new_pos_size].first > pos

        new_pos = drive[:free][new_pos_size].shift
        remains = new_pos_size - size
        drive[:files][i] = [size, new_pos]
        drive[:free][remains] = (drive[:free][remains] + [new_pos + size]).sort
      end
      drive[:files].sum do |i, (size, pos)|
        size.times.sum do |j|
          i * (pos + j)
        end
      end
    end

    def sectors(input)
      input.chars.each_slice(2).with_index.each_with_object([]) do |((file, space), i), acc|
        acc.push(*Array.new(file.to_i, i))
        acc.push(*Array.new(space.to_i, nil))
      end
    end

    def partitions(input)
      position = 0
      input.chars
           .each_slice(2)
           .with_index
           .each_with_object({ files: {}, free: {} }) do |((file, space), i), acc|
        acc[:files][i] = [file.to_i, position]
        acc[:free][space.to_i] ||= []
        acc[:free][space.to_i].push(position + file.to_i)
        position += file.to_i + space.to_i
      end
    end
  end
end
