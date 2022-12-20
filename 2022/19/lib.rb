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
      input.each_with_index.inject(0) do |acc, (costs, index)|
        max_geodes = 0
        max_target = []

        each_buy_strategy do |target|
          f = fitness(costs, target)
          if f > max_geodes
            max_geodes = f
            max_target = target
          end
        end
        p max_geodes
        p max_target
        acc + max_geodes * (index + 1)
      end
    end

    def problem2(input)
    end

    private

    def can_buy_in(robots, ores, costs)
      costs.each_with_index.map do |cost, i|
        times = cost.each_with_index.map do |price, p_i|
          if price.zero?
            0
          elsif robots[p_i].zero?
            1_000_000
          else
            n = (price - ores[p_i]).to_f / robots[p_i]
            n.negative? ? 0 : n
          end
        end
        times.max
      end
    end

    def buy_robot(num, index)
      Array.new(num, index).flatten
    end
  
    def each_buy_strategy
      (0..5).each do |ore|
        (0..3).each do |ore_clay|
          (0..2).each do |ore_clay_obs|
            (0..7).each do |clay|
              (0..3).each do |clay_obs|
                (0..2).each do |clay_obs_geod|
                  (0..5).each do |obs|
                    (0..3).each do |obs_geod|
                      yield(
                        buy_robot(ore, 0) + buy_robot(ore_clay, [1, 0]) + buy_robot(ore_clay_obs, [1, 0, 2]) +
                        buy_robot(clay, 1) + buy_robot(clay_obs, [2, 1]) + buy_robot(clay_obs_geod, [2, 1, 3]) +
                        buy_robot(obs, 2) + buy_robot(obs_geod, [3, 2]) + buy_robot(10, 3)
                      )
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    def fitness(costs, target)
      target = target.dup
      robots = [1, 0, 0, 0]
      ores = [0, 0, 0, 0]
      24.times do |time|
        ores_mined = robots.dup
        if !target.empty? && costs[target.first].each_with_index.all? { |cost, i| ores[i] >= cost }
          buy = target.shift
          costs[buy].each_with_index { |cost, i| ores[i] -= cost }
          robots[buy] += 1
        end
        ores_mined.each_with_index do |amnt, i|
          ores[i] += amnt
        end
      end
      ores.last
    end

    def ga
      population = Array.new(1000) do
        gene = Array.new(24) { rand(0..3) }
        [fitness(costs, gene), gene]
      end
      loop do
        total_fitness = population.map(&:first).sum
        population.sort_by!(&:first)
        break if total_fitness.zero?

        cum_prob = population.each_with_object([]) do |(f, _), acc|
          acc.push((acc.last || 0) + f.to_f / total_fitness)
        end
        i = 0
        while i.nil? || i.zero?
          cross_r = rand
          i = cum_prob.index { |rf| rf > cross_r }
        end
        cross_gene1 = population[i][1].dup
        cross_gene2 = population[i - 1][1].dup
        splice_i = rand(0...population.size)
        cross_gene1[..splice_i] = population[i - 1][1][..splice_i]
        cross_gene2[..splice_i] = population[i][1][..splice_i]
        population[0][1] = cross_gene1
        population[0][0] = fitness(costs, cross_gene1)
        population[1][1] = cross_gene2
        population[1][0] = fitness(costs, cross_gene2)
        if rand < 0.02
          mut_gene = population[rand(0...population.length)][1].dup
          mut_gene[rand(0...24)] = rand(0..3)
          population[2][1] = mut_gene
          population[2][0] = fitness(costs, mut_gene)
        end
        puts population.map(&:first).max
      end
    end
  end
end
# [24, {:ore=>{:ore=>4}, :clay=>{:ore=>2}, :obsidian=>{:ore=>3, :clay=>14}, :geode=>{:ore=>2, :obsidian=>7}}, {:ore=>6, :clay=>41, :obsidian=>8, :geode=>9}, {:ore=>1, :clay=>4, :obsidian=>2, :geode=>2}, ["0 - wait", "1 - wait", "2 - clay", "3 - wait", "4 - clay", "5 - wait", "6 - clay", "7 - wait", "8 - wait", "9 - wait", "10 - obsidian", "11 - clay", "12 - wait", "13 - wait", "14 - obsidian", "15 - wait", "16 - wait", "17 - geode", "18 - wait", "19 - wait", "20 - geode", "21 - wait", "22 - wait", "23 - wait"]]

# [24, {:ore=>{:ore=>2}, :clay=>{:ore=>3}, :obsidian=>{:ore=>3, :clay=>8}, :geode=>{:ore=>3, :obsidian=>12}}, {:ore=>21, :clay=>45, :obsidian=>18, :geode=>12}, {:ore=>4, :clay=>6, :obsidian=>6, :geode=>3}, ["0 - wait", "1 - wait", "2 - ore", "3 - wait", "4 - ore", "5 - clay", "6 - clay", "7 - clay", "8 - clay", "9 - clay", "10 - clay", "11 - obsidian", "12 - obsidian", "13 - obsidian", "14 - obsidian", "15 - ore", "16 - obsidian", "17 - geode", "18 - obsidian", "19 - geode", "20 - wait", "21 - geode", "22 - wait", "23 - wait"]]


