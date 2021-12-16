# frozen_string_literal: true

# https://adventofcode.com/2021/day/16
module Day16
  def process_input(str)
    [str.chomp].pack("H*").unpack1("B*")
  end

  def problem1(input)
    version, = process_packet_version(input, 0)
    version
  end

  def problem2(input)
    value, = process_packet(input, 0)
    value
  end

  protected

  OPERATORS = {
    0 => ->(values) { values.inject(&:+) },
    1 => ->(values) { values.inject(1) { |acc, v| acc * v } },
    2 => ->(values) { values.min },
    3 => ->(values) { values.max },
    5 => ->(values) { values.inject(&:>) ? 1 : 0 },
    6 => ->(values) { values.inject(&:<) ? 1 : 0 },
    7 => ->(values) { values.inject(&:==) ? 1 : 0 },
  }.freeze

  def process_packet_version(input, pointer)
    version = input[pointer, 3].to_i(2)
    type = input[pointer + 3, 3].to_i(2)
    pointer += 6
    case type
    when 4
      _, pointer = process_value(input, pointer)
      [version, pointer]
    else
      if input[pointer] == "0"
        len = input[pointer + 1, 15].to_i(2)
        pointer += 16
        limit = pointer + len
        while pointer < limit
          new_version, pointer = process_packet_version(input, pointer)
          version += new_version
        end
      else
        num = input[pointer + 1, 11].to_i(2)
        pointer += 12
        num.times do
          new_version, pointer = process_packet_version(input, pointer)
          version += new_version
        end
      end
      [version, pointer]
    end
  end

  def process_packet(input, pointer)
    type = input[pointer + 3, 3].to_i(2)
    pointer += 6
    case type
    when 4
      process_value(input, pointer)
    else
      if input[pointer] == "0"
        len = input[pointer + 1, 15].to_i(2)
        pointer += 16
        limit = pointer + len
        values = []
        while pointer < limit
          value, pointer = process_packet(input, pointer)
          values.push(value)
        end
      else
        num = input[pointer + 1, 11].to_i(2)
        pointer += 12
        values = []
        num.times do
          value, pointer = process_packet(input, pointer)
          values.push(value)
        end
      end
      [operator(type, values), pointer]
    end
  end

  def process_value(input, pointer)
    bits = value_bits(input, pointer)
    [bits.join.to_i(2), pointer + (bits.size * 5)]
  end

  def value_bits(input, pointer)
    bits = input[pointer..].chars.each_slice(5).take_while { |s| s.first == "1" }.map { |s| s[1..].join }
    bits.push(input[(pointer + 1), 4].chars)
    bits
  end

  def operator(type, values)
    OPERATORS[type].call(values)
  end
end
