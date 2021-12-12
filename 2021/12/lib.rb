# frozen_string_literal: true

# https://adventofcode.com/2021/day/12
module Day12
  def process_input(str)
    str.split("\n").reject(&:empty?).each_with_object({}) do |l, acc|
      a, b = l.split("-")
      acc[a] ||= []
      acc[a] |= [b]
      acc[b] ||= []
      acc[b] |= [a]
    end
  end

  def problem1(input)
    paths = input["start"].map { |cave| ["start", cave] }
    while paths.any? { |path| path.last != "end" }
      paths = paths.each_with_object([]) do |path, acc|
        acc.push(path) && next if path.last == "end"

        input[path.last].each do |cave|
          acc.push([*path, cave])
        end
      end

      paths = paths.reject do |path|
        path.tally.any? { |cave, num| cave == cave.downcase && num > 1 }
      end
    end
    paths.size
  end

  def problem2(input)
    paths = input["start"].map { |cave| ["start", cave] }
    while paths.any? { |path| path.last != "end" }
      paths = paths.each_with_object([]) do |path, acc|
        acc.push(path) && next if path.last == "end"

        input[path.last].each do |cave|
          acc.push([*path, cave])
        end
      end

      paths = paths.reject do |path|
        tally = path.tally.select { _1 == _1.downcase }
        tally["start"] > 1 || tally.any? { _2 > 2 } || tally.count { _2 > 1 } > 1
      end
    end
    paths.size
  end
end
