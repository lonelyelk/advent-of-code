# frozen_string_literal: true

# https://adventofcode.com/2022/day/13
module Year2022
  module Day13
    def process_input(str)
      str.split("\n\n").reject(&:empty?).map do |pair|
        pair.split("\n", 2).map { |l| eval(l) }
      end
    end

    def problem1(input)
      out = 0
      input.each_with_index do |(list_a, list_b), i|
        out += i + 1 if compare_pattern(list_a, list_b).negative?
      end
      out
    end

    def problem2(input)
      data = [*input.flatten(1), [[2]], [[6]]].sort { |a, b| compare_pattern(a, b) }
      (1 + data.index([[2]])) * (1 + data.index([[6]]))
    end

    private

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
    def compare(list_a, list_b)
      if list_a.is_a?(Numeric)
        return 1 if list_b.nil?

        return list_a <=> list_b if list_b.is_a?(Numeric)

        return compare([list_a], list_b)
      elsif list_b.is_a?(Numeric)
        return -1 if list_a.nil?

        return compare(list_a, [list_b])
      end

      return list_b.nil? || list_b.empty? ? 0 : -1 if list_a.nil? || list_a.empty?

      return 1 if list_b.nil? || list_b.empty?

      extend_and_zip(list_a, list_b).each do |(a, b)|
        re = compare(a, b)
        return re unless re.zero?
      end

      0
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    def compare_pattern(list_a, list_b)
      case [list_a, list_b]
      in [nil, nil] | [[], []]
        0
      in [nil, *] | [[], [*]]
        -1
      in [*, nil] | [[*], []]
        1
      in [Numeric, Numeric]
        list_a <=> list_b
      in [Numeric, Array]
        compare_pattern([list_a], list_b)
      in [Array, Numeric]
        compare_pattern(list_a, [list_b])
      in [[a, *rest_a], [b, *rest_b]]
        re = compare_pattern(a, b)
        if re.zero?
          compare_pattern(rest_a, rest_b)
        else
          re
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def extend_and_zip(list_a, list_b)
      new_list_a =
        if list_b.size > list_a.size
          [*list_a, *Array.new(list_b.size - list_a.size, nil)]
        else
          list_a
        end
      new_list_a.zip(list_b)
    end
  end
end
