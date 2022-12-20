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
        robots = [1, 0, 0, 0]
        ores = [0, 0, 0, 0]
        24.times do |time|
          ores_mined = robots.dup
          current_prediction = can_buy_in(robots, ores, costs)
          possible_accelerate = current_prediction.each_with_index.map do |int, i|
            next unless int.zero?

            r = robots.dup
            o = ores.dup
            r[i] += 1
            costs[i].each_with_index { |c, c_i| o[c_i] -= c }
            can_buy_in(r, o, costs)
          end
          if current_prediction.last == 0
            costs[3].each_with_index { |cost, i| ores[i] -= cost }
            robots[3] += 1
          elsif (next_buy = possible_accelerate.rindex { |e| !e.nil? })
            if possible_accelerate[next_buy].each_with_index.any? { |nb, i| i > next_buy && nb < current_prediction[i] }
              # (possible_accelerate[next_buy].each_with_index.any? { |nb, i| i > next_buy && nb < current_prediction[i] } ||
              # possible_accelerate[next_buy].each_with_index.all? { |nb, i| i <= next_buy || nb <= current_prediction[i] })
              costs[next_buy].each_with_index { |cost, i| ores[i] -= cost }
              robots[next_buy] += 1
            elsif possible_accelerate[0] && costs[0][0] < costs[1][0]
              costs[0].each_with_index { |cost, i| ores[i] -= cost }
              robots[0] += 1
            end
          end
          ores_mined.each_with_index do |amnt, i|
            ores[i] += amnt
          end
          print "#{time + 1} . "
          p [ores, robots, current_prediction, possible_accelerate]
        end
        puts
        acc + ores.last * (index + 1)
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
  end
end
