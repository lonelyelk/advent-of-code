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
    explore_and_reject(input) { |path| bad_path1(path) }
  end

  def problem2(input)
    explore_and_reject(input) { |path| bad_path2(path) }
  end

  protected

  def expand_paths(paths, input)
    paths.each_with_object([]) do |path, acc|
      acc.push(path) && next if path.last == "end"

      input[path.last].each do |cave|
        acc.push([*path, cave])
      end
    end
  end

  def explore_and_reject(input, &)
    paths = input["start"].map { |cave| ["start", cave] }
    while paths.any? { |path| path.last != "end" }
      paths = expand_paths(paths, input)
      paths = paths.reject(&)
    end
    paths.size
  end

  def bad_path1(path)
    path.tally.any? { |cave, num| cave == cave.downcase && num > 1 }
  end

  def bad_path2(path)
    tally = path.tally.select { _1 == _1.downcase }
    tally["start"] > 1 || tally.values.any? { |cnt| cnt > 2 } || tally.values.count { |cnt| cnt > 1 } > 1
  end
end
