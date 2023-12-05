# frozen_string_literal: true

# https://adventofcode.com/2023/day/5
module Year2023
  module Day05
    def process_input(str)
      result = { maps: [] }
      seeds, *maps = str.split("\n\n")
      result[:seed] = seeds.split(":")[1].split.map(&:to_i)
      maps.each_with_object(result) do |map_rep, res|
        name, *ms = map_rep.split("\n").reject(&:empty?)
        names = name.split.first.strip.split("-to-").map(&:to_sym)
        ranges = ms.map { |m| m.split.map(&:to_i) }
        res[:maps].push([names, *ranges])
      end
    end

    def problem1(input)
      source = :seed
      answer = input[:seed]
      while source != :location
        map = input[:maps].detect { |m| m[0][0] == source }
        raise "Map not found #{map}" unless map

        answer = answer.map do |num|
          dest_num = nil
          map[1..].each do |m|
            dest_num = m[0] + num - m[1] if num >= m[1] && num < m[1] + m[2]
          end
          dest_num || num
        end
        source = map[0][1]
      end
      answer.min
    end

    def problem2(input)
      source = :seed
      answer = input[:seed]
      while source != :location
        map = input[:maps].detect { |m| m[0][0] == source }
        raise "Map not found #{map}" unless map

        answer = answer.each_slice(2).flat_map do |(start, size)|
          source_ranges = [start, size]
          map[1..].each do |m|
            source_ranges = source_ranges.each_slice(2).flat_map do |(st, sz)|
              re = []
              if st < m[1] && st + sz > m[1]
                re.push(st, m[1] - st)
                sz = st + sz - m[1]
                st = m[1]
              end
              if st < m[1] + m[2] && st + sz > m[1] + m[2]
                re.push(st, m[1] + m[2] - st)
                sz = sz + st - m[1] - m[2]
                st = m[1] + m[2]
              end
              re.push(st, sz)
            end
          end
          source_ranges.each_slice(2).flat_map do |(num, sz)|
            dest_num = nil
            map[1..].each do |m|
              dest_num = m[0] + num - m[1] if num >= m[1] && num < m[1] + m[2]
            end
            [dest_num || num, sz]
          end
        end
        source = map[0][1]
      end
      answer.each_slice(2).map(&:first).min
    end
  end
end
