# frozen_string_literal: true

# https://adventofcode.com/2022/day/7
module Year2022
  module Day07
    def process_input(str)
      current_path = []
      str.split("\n").reject(&:empty?)[1..].each_with_object({}) do |line, acc|
        if line[0] == ?$
          if (md = line.match(/\$ cd \.\./))
            current_path.pop
          elsif (md = line.match(/\$ cd (.+)/))
            current_path.push(md[1])
          end
        elsif (md = line.match(/dir (.+)/))
          current_path.inject(acc) { |a, n| a[n] }[md[1]] = {}
        elsif (md = line.match(/(\d+) (.+)/))
          current_path.inject(acc) { |a, n| a[n] }[md[2]] = md[1].to_i
        end
      end
    end

    def problem1(input)
      sizes = get_dir_sizes(input).values
      sizes.reject { |v| v > 100000 }.inject(&:+)
    end

    def problem2(input)
      dir_sizes = get_dir_sizes(input)
      to_free = 30000000 - (70000000 - dir_sizes["/"])
      dir_sizes.values.reject { |v| v < to_free }.min
    end

    protected

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
