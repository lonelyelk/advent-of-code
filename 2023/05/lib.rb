# frozen_string_literal: true

# https://adventofcode.com/2023/day/5
module Year2023
  module Day05
    def process_input(str)
      result = {}
      seeds, *maps = str.split("\n\n")
      result[:seed] = seeds.split(":")[1].split.map(&:to_i)
      result[:maps] = process_maps(maps)
      result
    end

    def problem1(input)
      source = :seed
      answer = input[source]
      while source != :location
        vmap, source = next_map_source(input[:maps], source)
        answer = answer.map { |num| map_to_dest(num, vmap) }
      end
      answer.min
    end

    def problem2(input)
      source = :seed
      answer = input[source].each_slice(2).to_a
      while source != :location
        vmap, source = next_map_source(input[:maps], source)
        answer = answer.inject([]) do |acc, source_range|
          acc + split_range_for_map(source_range, vmap).map { |(num, size)| [map_to_dest(num, vmap), size] }
        end
      end
      answer.map(&:first).min
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

    def next_map_source(maps, source)
      map = maps.detect { |m| m[0][0] == source }
      raise("Map not found #{source}") unless map

      [map[1..], map[0][1]]
    end

    def map_to_dest(num, vmap)
      dest_num = nil
      vmap.each do |(dest_st, src_st, sz)|
        dest_num = dest_st + num - src_st if num >= src_st && num < src_st + sz
      end
      dest_num || num
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def split_range_for_map(source_range, vmap)
      vmap.inject([source_range]) do |ranges, (_, st, sz)|
        ranges.each_with_object([]) do |(start, size), re|
          if start < st && start + size > st
            re.push([start, st - start])
            size = start + size - st
            start = st
          end
          if start < st + sz && start + size > st + sz
            re.push([start, st + sz - start])
            size = size + start - st - sz
            start = st + sz
          end
          re.push([start, size])
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
  end
end
