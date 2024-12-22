# frozen_string_literal: true

# https://adventofcode.com/2024/day/19
module Year2024
  module Day19
    def process_input(str)
      avail, desired = str.split("\n\n")
      avail = avail.split(", ")
      avail_min, avail_max = avail.map(&:size).minmax
      avail_set = avail.each_with_object({}) { |ptr, acc| acc[ptr] = true }
      [desired.split("\n"), { set: avail_set, range: (avail_min..avail_max) }]
    end

    # rubocop:disable Metrics/MethodLength
    def problem1(input)
      desired, avail = input
      desired.count do |pattern|
        set = { pattern => true }
        loop do
          set = set.each_with_object({}) do |(ptr, _), acc|
            avail[:range].each do |size|
              acc[ptr[size..]] = true if avail[:set][ptr[...size]]
            end
          end
          break if set.empty?
          break true if set[""]
        end
      end
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    def problem2(input)
      desired, avail = input
      desired.sum do |pattern|
        possible = 0
        set = { pattern => 1 }
        loop do
          set = set.each_with_object(Hash.new(0)) do |(ptr, cnt), acc|
            next if ptr.nil?

            if ptr == ""
              possible += cnt
              next
            end

            avail[:range].each do |size|
              acc[ptr[size..]] += cnt if avail[:set][ptr[...size]]
            end
          end
          break if set.except("").empty?
        end
        set.values.sum + possible
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
  end
end
