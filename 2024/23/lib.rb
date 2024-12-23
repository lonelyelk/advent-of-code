# frozen_string_literal: true

# https://adventofcode.com/2024/day/23
module Year2024
  module Day23
    def process_input(str)
      str.split("\n").each_with_object(Hash.new { |h, k| h[k] = [] }) do |line, acc|
        comp1, comp2 = line.split("-")
        acc[comp1].push(comp2)
        acc[comp2].push(comp1)
      end
    end

    def problem1(input)
      subnets(input).count { |net| net.any? { |c| c =~ /^t/ } }
    end

    # rubocop:disable Metrics/AbcSize
    def problem2(input)
      nets = subnets(input)
      until nets.size == 1
        nets = nets.each_with_object([]) do |net, acc|
          connections = net.map { |n| input[n] }
          add = connections[0].find { |comp| connections[1..].all? { |other| other.include?(comp) } }
          acc.push([add, *net].sort) if add
        end.uniq
      end
      nets.first.join(",")
    end
    # rubocop:enable Metrics/AbcSize

    def subnets(input)
      input.each_with_object([]) do |(comp, net), acc|
        next if net.size < 2

        net[..-2].each_with_index do |comp1, i|
          net[(i + 1)..].each do |comp2|
            acc.push([comp, comp1, comp2].sort) if input[comp1].include? comp2
          end
        end
      end.uniq
    end
  end
end
