# frozen_string_literal: true

# https://adventofcode.com/2021/day/16
module Day16
  def process_input(str)
    [str.chomp].pack("H*").unpack("B*").first
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

  def process_packet_version(input, pointer)
    version = input[pointer, 3].to_i(2)
    case input[pointer + 3, 3].to_i(2)
    when 4
      pointer += 6
      bits = input[pointer..].chars.each_slice(5).take_while { |s| s.first == "1" }.map { |s| s[1..].join }
      pointer += bits.size * 5
      bits.push(input[(pointer + 1), 4])
      pointer += 5
      [version, pointer]
    else
      pointer += 6
      if input[pointer] == "0"
        len = input[pointer + 1, 15].to_i(2)
        pointer += 16
        limit = pointer + len
        while pointer < limit
          new_version, pointer = process_packet_version(input, pointer)
          version += new_version
        end
        [version, pointer]
      else
        num = input[pointer + 1, 11].to_i(2)
        pointer += 12
        new_version, pointer = (0...num).to_a.inject([version, pointer]) do |(vn, pt), i|
          new_vn, new_pt = process_packet_version(input, pt)
          [vn + new_vn, new_pt]
        end
        [new_version, pointer]
      end
    end
  end

  def process_packet(input, pointer)
    type = input[pointer + 3, 3].to_i(2)
    case type
    when 4
      pointer += 6
      bits = input[pointer..].chars.each_slice(5).take_while { |s| s.first == "1" }.map { |s| s[1..].join }
      pointer += bits.size * 5
      bits.push(input[(pointer + 1), 4])
      pointer += 5
      [bits.join.to_i(2), pointer]
    else
      pointer += 6
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
      case type
      when 0
        [values.inject(&:+), pointer]
      when 1
        [values.inject(1) { |acc, v| acc * v}, pointer]
      when 2
        [values.min, pointer]
      when 3
        [values.max, pointer]
      when 5
        [values.first > values[1] ? 1 : 0, pointer]
      when 6
        [values.first < values[1] ? 1 : 0, pointer]
      when 7
        [values.first == values[1] ? 1 : 0, pointer]
      end
    end
  end
end
