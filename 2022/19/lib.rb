# frozen_string_literal: true

# https://adventofcode.com/2022/day/19
module Year2022
  module Day19
    def process_input(str)
      str.scan(/Blueprint \d+.+?Each ore robot costs (\d+) ore.+?Each clay robot costs (\d+) ore.+?Each obsidian robot costs (\d+) ore and (\d+) clay.+?Each geode robot costs (\d+) ore and (\d+) obsidian/m).map do |a, b, c, d, e, f|
        [[a.to_i], [b.to_i], [c.to_i, d.to_i], [e.to_i, 0, f.to_i]]
      end
    end

    def problem1(input)
      @max_time = 24
      input.each_with_index.inject(0) do |acc, (costs, index)|
        @max_geodes = 0
        @max_robots = (0..3).map do |i|
          max_cost = costs.map { |cost| cost[i] }.compact.max
          max_cost.nil? ? 1_000_000 : max_cost
        end
        robots = [1, 0, 0, 0]
        ores = [0, 0, 0, 0]

        acc + recursive_solve(0, costs, robots, ores) * (index + 1)
      end
    end

    def problem2(input)
      @max_time = 32
      input[...3].inject(1) do |acc, costs|
        @max_geodes = 0
        @max_robots = (0..3).map do |i|
          max_cost = costs.map { |cost| cost[i] }.compact.max
          max_cost.nil? ? 1_000_000 : max_cost
        end
        robots = [1, 0, 0, 0]
        ores = [0, 0, 0, 0]

        acc * recursive_solve(0, costs, robots, ores)
      end
    end

    private

    def recursive_solve(time, costs, robots, ores)
      if time == @max_time
        return @max_geodes = [ores.last, @max_geodes].max
      end

      if ores.last + (0..(@max_time - time)).inject(0) { |acc, n| acc + n + robots.last } < @max_geodes
        return 0
      end

      costs.each_with_index.map do |cost, i|
        if cost.each_with_index.all? { |price, ore_i| price.zero? || robots[ore_i].positive? } &&
            robots[i] < @max_robots[i]
          need_time = cost.each_with_index.map { |price, ore_i| [(price - ores[ore_i]).to_f / robots[ore_i], 0].max.ceil }.max + 1
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
  end
end
