# frozen_string_literal: true

# https://adventofcode.com/2022/day/7
module Year2022
  module Day07
    def process_input(str)
      current_path = []
      lines(str).each_with_object({}) do |line, acc|
        update_path(current_path, line)

        md = line.match(/^(dir|\d+) (.+)/)
        next if md.nil?

        current_path.inject(acc, &:[])[md[2]] = md[1] == "dir" ? {} : md[1].to_i
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
      md = cmd.match(/^\$ cd (.+)/)
      return if md.nil?

      if md[1] == ".."
        path.pop
      else
        path.push(md[1])
      end
    end

    def get_dir_sizes(input, accumulator = {}, prefix = "/")
      accumulator[prefix] ||= 0
      input.each_with_object(accumulator) do |(name, value), acc|
        if value.is_a?(Numeric)
          acc[prefix] += value
        else
          next_prefix = "#{prefix}#{name}/"
          get_dir_sizes(value, acc, next_prefix)
          acc[prefix] += acc[next_prefix]
        end
      end
    end
  end
end
