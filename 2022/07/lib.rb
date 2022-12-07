# frozen_string_literal: true

# https://adventofcode.com/2022/day/7
module Year2022
  module Day07
    def process_input(str)
      current_path = []
      lines(str).each_with_object({}) do |line, acc|
        current_path = update_path(current_path, line)

        if (md = line.match(/^dir (.+)/))
          current_path.inject(acc, &:[])[md[1]] = {}
        elsif (md = line.match(/^(\d+) (.+)/))
          current_path.inject(acc, &:[])[md[2]] = md[1].to_i
        end
      end
    end

    def problem1(input)
      sizes = get_dir_sizes(input).values
      sizes.reject { |v| v > 100_000 }.inject(&:+)
    end

    def problem2(input)
      dir_sizes = get_dir_sizes(input)
      to_free = 30_000_000 - (70_000_000 - dir_sizes["/"])
      dir_sizes.values.reject { |v| v < to_free }.min
    end

    protected

    def lines(str)
      str.split("\n").reject(&:empty?)[1..]
    end

    def update_path(path, cmd)
      if cmd =~ /^\$ cd \.\./
        path.pop
      elsif (md = cmd.match(/^\$ cd (.+)/))
        path.push(md[1])
      end
      path
    end

    def get_dir_sizes(input, accumulator = {}, prefix = "/")
      input.each_with_object(accumulator) do |(name, value), acc|
        if value.is_a?(Numeric)
          acc[prefix] ||= 0
          acc[prefix] += value
        else
          get_dir_sizes(value, acc, "#{prefix}#{name}/")
          acc[prefix] ||= 0
          acc[prefix] += acc["#{prefix}#{name}/"]
        end
      end
    end
  end
end
