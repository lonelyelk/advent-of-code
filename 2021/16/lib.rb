# frozen_string_literal: true

module Day16
  def process_input(str)
    [str.chomp].pack("H*").unpack("B*").first
  end

  def problem1(input)
    pointer = 0
    version = 0
    while pointer < input.size - 8
      vn, pointer = process_packet_version(input, pointer)
      version += vn
    end
    version
  end

  def problem2(input)
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
end
