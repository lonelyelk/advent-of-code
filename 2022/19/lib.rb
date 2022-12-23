# frozen_string_literal: true

# https://adventofcode.com/2022/day/19
module Year2022
  module Day19
    def process_input(str)
      str.scan(blueprint_regexp).map do |md|
        nums = md.map(&:to_i)
        [[nums[0]], [nums[1]], [nums[2], nums[3]], [nums[4], 0, nums[5]]]
      end
    end

    def problem1(input)
      @max_time = 24
      input.each_with_index.inject(0) do |acc, (costs, index)|
        @max_geodes = 0
        count_max_robots!(costs)

        acc + recursive_solve(0, costs, [1, 0, 0, 0], Array.new(4, 0)) * (index + 1)
      end
    end

    def problem2(input)
      @max_time = 32
      input[...3].inject(1) do |acc, costs|
        @max_geodes = 0
        count_max_robots!(costs)

        acc * recursive_solve(0, costs, [1, 0, 0, 0], Array.new(4, 0))
      end
    end

    private

    def blueprint_regexp
      blueprint = <<~'TEXT'.chomp
        Blueprint \d+:
          Each ore robot costs (\d+) ore.
          Each clay robot costs (\d+) ore.
          Each obsidian robot costs (\d+) ore and (\d+) clay.
          Each geode robot costs (\d+) ore and (\d+) obsidian
      TEXT
      Regexp.new(blueprint.gsub(/[:.]\n\s+/, ".+?"), Regexp::MULTILINE)
    end

    def count_max_robots!(costs)
      @max_robots = (0..3).map do |i|
        max_cost = costs.map { |cost| cost[i] }.compact.max
        max_cost.nil? ? 1_000_000 : max_cost
      end
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    def recursive_solve(time, costs, robots, ores)
      return @max_geodes = [ores.last, @max_geodes].max if time == @max_time

      # Super-optimistic prediction if we buy a new geode robot every minute and won't get more,
      # we have no chance either way. So we discard a solution that brings no hope.
      return 0 if ores.last + (0...(@max_time - time)).inject(0) { |acc, n| acc + n + robots.last } <= @max_geodes

      costs.each_with_index.map do |cost, i|
        if cost.each_with_index.all? { |price, o_i| price.zero? || robots[o_i].positive? } &&
           robots[i] < @max_robots[i]
          need_time = cost.each_with_index.map do |price, o_i|
            [(price - ores[o_i]).to_f / robots[o_i], 0].max.ceil
          end.max + 1
          if need_time + time <= @max_time
            recursive_solve(
              time + need_time,
              costs,
              robots.each_with_index.map { |r, r_i| r_i == i ? r + 1 : r },
              ores.each_with_index.map { |o, o_i| o - (cost[o_i] || 0) + robots[o_i] * need_time }
            )
          else
            recursive_solve(
              @max_time,
              costs,
              robots,
              ores.each_with_index.map { |o, o_i| o + robots[o_i] * (@max_time - time) }
            )
          end
        else
          0
        end
      end.max
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  end
end
