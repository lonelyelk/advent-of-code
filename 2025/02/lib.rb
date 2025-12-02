# frozen_string_literal: true

# https://adventofcode.com/2025/day/2
module Year2025
  module Day02
    def process_input(str)
      str.split(/,\n?/).map do |r|
        r.split("-").map(&:strip)
      end
    end

    def problem1(input)
      input.sum do |(first, last)|
        if first.length.odd? && first.length == last.length
          0
        else
          min = next_rep_part(first)
          max = prev_rep_part(last)
          min.upto(max).sum { |num| "#{num}#{num}".to_i }
        end
      end
    end

    def problem2(input)
      input.each_with_object({}) do |(first, last), acc|
        rep_parts_number(first, last).each do |num|
          min = next_rep_part(first, num)
          max = prev_rep_part(last, num)
          min.upto(max).each do |n|
            acc[(n.to_s * num).to_i] = true
          end
        end
      end.keys.sum
    end

    private

    def next_rep_part(str, num = 2)
      if (str.length % num).zero?
        left = str[...(str.length / num)].to_i
        (left.to_s * num).to_i < str.to_i ? left + 1 : left
      else
        10 * (str.length / num)
      end
    end

    def prev_rep_part(str, num = 2)
      if (str.length % num).zero?
        left = str[...(str.length / num)].to_i
        (left.to_s * num).to_i > str.to_i ? left - 1 : left
      else
        ("9" * (str.length / num)).to_i
      end
    end

    def rep_parts_number(first, last)
      first.length.upto(last.length).flat_map do |i|
        2.upto(i).select { |j| (i % j).zero? }
      end.uniq
    end
  end
end
