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
    else
      process_subpacket(input, pointer) do |pt|
        new_version, pointer = process_packet_version(input, pt)
        version += new_version
        pointer
      end
    end
    [version, pointer]
  end

  def process_packet(input, pointer)
    type = input[pointer + 3, 3].to_i(2)
    pointer += 6
    case type
    when 4
      process_value(input, pointer)
    else
      values = []
      process_subpacket(input, pointer) do |pt|
        value, pointer = process_packet(input, pt)
        values.push(value)
        pointer
      end
      [operator(type, values), pointer]
    end
  end

  def process_value(input, pointer)
    bits = value_bits(input, pointer)
    [bits.join.to_i(2), pointer + (bits.size * 5)]
  end

  def value_bits(input, pointer)
    bits = input[pointer..].chars.each_slice(5).take_while { |s| s.first == "1" }.map(&:join)
    bits.push(input[pointer + (bits.size * 5), 5])
    bits.map { |s| s[1..] }
  end

  def operator(type, values)
    OPERATORS[type].call(values)
  end

  def process_subpacket(input, pointer, &block)
    if input[pointer] == "0"
      len = input[pointer + 1, 15].to_i(2)
      pointer += 16
      limit = pointer + len
      pointer = block.call(pointer) while pointer < limit
    else
      num = input[pointer + 1, 11].to_i(2)
      pointer += 12
      num.times { pointer = block.call(pointer) }
    end
  end
end
