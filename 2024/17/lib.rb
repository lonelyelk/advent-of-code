# frozen_string_literal: true

# https://adventofcode.com/2024/day/17
module Year2024
  module Day17
    def process_input(str)
      md = str.match(/A: (\d+)\n.+B: (\d+)\n.+C: (\d+)\n\n.+: ([0-9,]+)/)
      {
        a: md[1].to_i,
        b: md[2].to_i,
        c: md[3].to_i,
        p: md[4].split(",").map(&:to_i),
      }
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
    def problem1(input, target_out = nil)
      comp = input.dup
      instr = 0
      out = []
      while instr < comp[:p].size - 1
        opcode = comp[:p][instr]
        operand = comp[:p][instr + 1]
        # p [instr, opcode, operand]
        case opcode
        when 0
          comp[:a] /= 2**combo_operand(operand, comp)
        when 1
          comp[:b] ^= operand
        when 2
          comp[:b] = (combo_operand(operand, comp) % 8) & 0b111
        when 3
          instr = operand - 2 unless comp[:a].zero?
        when 4
          comp[:b] ^= comp[:c]
        when 5
          out.push(combo_operand(operand, comp) % 8)
        when 6
          comp[:b] = comp[:a] / 2**combo_operand(operand, comp)
        when 7
          comp[:c] = comp[:a] / 2**combo_operand(operand, comp)
        end
        break if target_out && out != target_out[...(out.size)]

        instr += 2
      end
      out.join(",")
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength

    def problem2(input)
      (input[:p].size - 1).downto(0).inject(0) do |acc, index|
        acc <<= 3
        octet = (0..7).each do |i|
          out = problem1(input.merge(a: acc | i), input[:p][index..])
          break i if out == input[:p][index..].join(",")
        end
        acc | octet
      end
    end

    def combo_operand(operand, comp)
      case operand
      when 0..3
        operand
      when 4..6
        comp[%i[a b c][operand - 4]]
      else
        raise "Unknown operand"
      end
    end
  end
end
