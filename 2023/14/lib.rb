# frozen_string_literal: true

# https://adventofcode.com/2023/day/14
module Year2023
  module Day14
    def process_input(str)
      str.split("\n")
    end

    def problem1(input)
      align_input = init_align(input)
      tilt_input = tilt(align_input)
      aligned_load(tilt_input)
    end

    def problem2(input)
      input = init_align(input)
      count = 0
      cache = {}
      until cache[key(input)]
        cache[key(input)] = { load: aligned_load(input), count: }
        4.times { input = next_align(tilt(input)) }
        count += 1
      end
      count_from_cache(count, input, cache)
    end

    private

    def init_align(input)
      input.map(&:chars).transpose.reverse.map(&:join)
    end

    def next_align(input)
      input.map(&:chars).transpose.map { |l| l.reverse.join }
    end

    def tilt(input)
      input.map do |line|
        "#{line} ".split("#").map do |stones|
          s = stones.strip
          count = s.count("O")
          "O" * count + "." * (s.size - count)
        end.join("#")
      end
    end

    def aligned_load(input)
      input.sum do |line|
        line.chars.each_with_index.sum do |c, i|
          c == "O" ? line.size - i : 0
        end
      end
    end

    def key(input)
      input.join(",")
    end

    def count_from_cache(count, input, cache)
      tail_count = cache[key(input)][:count]
      mod_count = tail_count + (1_000_000_000 - tail_count) % (count - tail_count)
      cache.values.detect { |v| v[:count] == mod_count }[:load]
    end
  end
end
