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

    # rubocop:disable Metrics/AbcSize
    def problem2(input)
      state = input.each_with_object(init_state) do |instr, s|
        label, box, op, lens = parse_instruction(instr)
        index = s[box].index { |l| l.first == label } || s[box].size
        op == "-" ? s[box].delete_at(index) : s[box][index] = lens
      end
      focusing_power(state)
    end
    # rubocop:enable Metrics/AbcSize

    private

    def init_state
      Array.new(256) { |_i| [] }
    end

    def hash(str)
      str.chars.inject(0) do |acc, c|
        (acc + c.ord) * 17 % 256
      end
    end

    def focusing_power(state)
      state.each_with_index.sum do |box, index|
        box.each_with_index.sum do |(_l, fl), pos|
          (index + 1) * (pos + 1) * fl
        end
      end
    end

    def parse_instruction(instr)
      md = instr.match(/(.+)([=-])(\d*)/)
      label = md[1]
      box = hash(label)
      [label, box, md[2], [label, md[3].to_i]]
    end
  end
end
