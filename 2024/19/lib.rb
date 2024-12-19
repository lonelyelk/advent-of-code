# frozen_string_literal: true

# https://adventofcode.com/2024/day/19
module Year2024
  module Day19
    def process_input(str)
      avail, desired = str.split("\n\n")
      [avail.split(", "), desired.split("\n")]
    end

    def problem1(input)
      avail, desired = input
      count = 0
      desired.count do |pattern|
        count += 1
        puts "#{count}/#{desired.size}"
        possible = false
        set = { pattern => true }
        loop do
          set = set.each_with_object({}) do |(ptr, _), acc|
            avail.select { |aptr| ptr.match?(/^#{aptr}/) }.each do |aptr|
              acc[ptr[(aptr.size..)]] = true
            end
          end
          break if set.empty?

          if set[""]
            possible = true
            break
          end
        end
        possible
      end
    end

    def problem2(input)
    end
  end
end
