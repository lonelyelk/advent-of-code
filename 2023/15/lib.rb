# frozen_string_literal: true

# https://adventofcode.com/2023/day/15
module Year2023
  module Day15
    def process_input(str)
      str.chomp.split(",")
    end

    def problem1(input)
      input.sum do |instr|
        hash(instr)
      end
    end

    def problem2(input)
      state = Array.new(256) { |_i| [] }
      state = input.each_with_object(state) do |instr, s|
        md = instr.match(/(.+)([=-])(\d*)/)
        label = md[1]
        box = hash(label)
        if md[2] == "-"
          s[box].reject! { |l| l.first == label }
        elsif (index = s[box].index { |l| l.first == label })
          s[box][index] = [label, md[3].to_i]
        else
          s[box].push([label, md[3].to_i])
        end
      end
      state.each_with_index.sum do |box, index|
        box.each_with_index.sum do |(_l, fl), pos|
          (index + 1) * (pos + 1) * fl
        end
      end
    end

    private

    def hash(str)
      str.chars.inject(0) do |acc, c|
        (acc + c.ord) * 17 % 256
      end
    end
  end
end
