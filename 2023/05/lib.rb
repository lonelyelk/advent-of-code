# frozen_string_literal: true

# https://adventofcode.com/2023/day/5
module Year2023
  module Day05
    def process_input(str)
      result = { maps: [] }
      seeds, *maps = str.split("\n\n")
      result[:seed] = seeds.split(":")[1].split.map(&:to_i)
      result[:maps] = process_maps(maps)
      result
    end

    def problem1(input)
      source = :seed
      answer = input[source]
      while source != :location
        map = input[:maps].detect { |m| m[0][0] == source }
        raise "Map not found #{map}" unless map

        answer = answer.map { |num| map_to_dest(num, map) }
        source = map[0][1]
      end
      answer.min
    end

    def problem2(input)
      source = :seed
      answer = input[source]
      while source != :location
        map = input[:maps].detect { |m| m[0][0] == source }
        raise "Map not found #{map}" unless map

        answer = answer.each_slice(2).flat_map do |source_range|
          source_ranges = split_range_for_map(source_range, map)
          source_ranges.each_slice(2).flat_map { |(num, size)| [map_to_dest(num, map), size] }
        end
        source = map[0][1]
      end
      answer.each_slice(2).map(&:first).min
    end

    private

    def process_maps(maps)
      maps.map do |map|
        name, *ms = map.split("\n").reject(&:empty?)
        names = name.split.first.strip.split("-to-").map(&:to_sym)
        ranges = ms.map { |m| m.split.map(&:to_i) }
        [names, *ranges]
      end
    end

    def map_to_dest(num, map)
      dest_num = nil
      map[1..].each do |m|
        dest_num = m[0] + num - m[1] if num >= m[1] && num < m[1] + m[2]
      end
      dest_num || num
    end

    def split_range_for_map(source_range, map)
      map[1..].inject(source_range) do |ranges, m|
        ranges.each_slice(2).flat_map do |(start, size)|
          re = []
          if start < m[1] && start + size > m[1]
            re.push(start, m[1] - start)
            size = start + size - m[1]
            start = m[1]
          end
          if start < m[1] + m[2] && start + size > m[1] + m[2]
            re.push(start, m[1] + m[2] - start)
            size = size + start - m[1] - m[2]
            start = m[1] + m[2]
          end
          re.push(start, size)
        end
      end
    end
  end
end
