# frozen_string_literal: true

# https://adventofcode.com/2022/day/6
module Year2022
  module Day06
    def process_input(str)
      str.chomp
    end

    def problem1(input)
      packet_offset(input, 4)
    end

    def problem2(input)
      packet_offset(input, 14)
    end

    protected

    def packet_offset(input, packet_size)
      (packet_size...input.size).detect do |i|
        input[(i - packet_size)...i].chars.uniq.size == packet_size
      end
    end
  end
end
