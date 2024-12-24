# frozen_string_literal: true

# https://adventofcode.com/2024/day/24
module Year2024
  module Day24
    # rubocop:disable Metrics/AbcSize
    def process_input(str)
      state, operations = str.split("\n\n")
      state = state.split("\n").each_with_object({}) do |line, acc|
        name, value = line.split(": ")
        acc[name] = value.to_i
      end
      operations = operations.split("\n").map do |line|
        md = line.match(/(\S+) (\S+) (\S+) -> (\S+)/)
        [md[2], md[1], md[3], md[4]]
      end
      { state:, operations: }
    end

    # rubocop:disable Metrics/MethodLength
    def problem1(input)
      state = input[:state].dup
      operations = input[:operations]
      until operations.empty?
        operations = operations.each_with_object([]) do |(op, in1, in2, out), acc|
          if state[in1].nil? || state[in2].nil?
            acc.push([op, in1, in2, out])
            next
          end
          state[out] = operate(op, state[in1], state[in2])
        end
      end
      get_value("z", state)
    end

    def problem2(input)
      carry = nil
      ops = input[:operations].dup
      num_bits(input[:state]).times.each_with_object([]) do |i, acc|
        num = format("%02d", i)
        x, y, z = %w[x y z].map { |c| c + num }
        if carry.nil?
          carry = find_by_op_input(ops, "AND", x, y).last
          next
        end
        xorxy = find_by_op_input(ops, "XOR", x, y)
        # This is manual intervention since it was easy to see when the algorithm stumbled upon
        # the output of x25 XOR y25 that was only input to an OR. I was unable to make code
        # for this generic and better understandable than the puzzle input on its own. The solution
        # relies on knowing the addition in binary using boolean logic. There maybe a better
        # analysis that just matching the output values when they are expected.
        if xorxy.last == "cbd"
          ops = swap_out(ops, xorxy, "rqf")
          acc.push("cbd", "rqf")
          xorxy = find_by_op_input(ops, "XOR", x, y)
        end
        xorxy = xorxy.last
        sum = find_by_op_input(ops, "XOR", xorxy, carry)
        if sum.last != z
          ops = swap_out(ops, sum, z)
          acc.push(sum.last, z)
        end
        andxy = find_by_op_input(ops, "AND", x, y).last
        andcarry = find_by_op_input(ops, "AND", carry, xorxy).last
        carry = find_by_op_input(ops, "OR", andcarry, andxy).last
      end.sort.join(",")
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def operate(operation, input1, input2)
      case operation
      when "AND"
        input1 & input2
      when "OR"
        input1 | input2
      when "XOR"
        input1 ^ input2
      end
    end

    def find_by_op_input(operations, operation, input1, input2)
      operations.detect do |op|
        [[operation, input1, input2], [operation, input2, input1]].include?(op[...-1])
      end
    end

    def swap_out(operations, operation, out)
      target_op = operations.detect { |a| a.last == out }

      operations.map do |op|
        if op == operation
          [*operation[...-1], out]
        elsif op == target_op
          [*op[...-1], operation[-1]]
        else
          op
        end
      end
    end

    def get_value(name, state)
      state.keys.grep(/^#{name}/).sum do |full_name|
        shift = full_name[1..].to_i
        state[full_name] << shift
      end
    end

    def set_value(name, value, state)
      state.keys.grep(/^#{name}/).each do |full_name|
        shift = full_name[1..].to_i
        state[full_name] = (value >> shift) & 1
      end
    end

    def num_bits(state)
      state.keys.grep(/^x/).size
    end
  end
end
