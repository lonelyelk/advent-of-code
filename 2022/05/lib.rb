# frozen_string_literal: true

# https://adventofcode.com/2022/day/5
module Year2022
  module Day05
    def process_input(str)
      stacks, procedure = str.split("\n\n").reject(&:empty?)

      { stacks: process_stacks(stacks), procedure: process_procedure(procedure) }
    end

    def problem1(input)
      input[:procedure].each_with_object(input[:stacks].map(&:dup)) do |operation, stacks|
        moved = stacks[operation[:from]].slice!((-operation[:amount])..)
        stacks[operation[:to]].push(*moved.reverse)
      end.map(&:last).join
    end

    def problem2(input)
      input[:procedure].each_with_object(input[:stacks].map(&:dup)) do |operation, stacks|
        moved = stacks[operation[:from]].slice!((-operation[:amount])..)
        stacks[operation[:to]].push(*moved)
      end.map(&:last).join
    end

    protected

    def process_stacks(stacks)
      stacks.split("\n").reject(&:empty?).reverse.each_with_object([]) do |line, acc|
        next if line =~ /\d/

        line.chars.each_slice(4).with_index do |crate, index|
          acc[index] ||= []
          acc[index].push(crate[1]) unless crate[1] == " "
        end
      end
    end

    def process_procedure(procedure)
      procedure.split("\n").reject(&:empty?).map do |line|
        md = line.match(/move (\d+) from (\d+) to (\d+)/)
        { amount: md[1].to_i, from: md[2].to_i - 1, to: md[3].to_i - 1 }
      end
    end
  end
end
