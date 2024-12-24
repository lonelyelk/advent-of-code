# frozen_string_literal: true

# https://adventofcode.com/2024/day/24
module Year2024
  module Day24
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

    def problem1(input)
      state = input[:state].dup
      operations = input[:operations]
      until operations.empty?
        operations = operations.each_with_object([]) do |(op, in1, in2, out), acc|
          if state[in1].nil? || state[in2].nil?
            acc.push([op, in1, in2, out])
            next
          end
          state[out] = case op
                       when "AND"
                         state[in1] & state[in2]
                       when "OR"
                         state[in1] | state[in2]
                       when "XOR"
                         state[in1] ^ state[in2]
                       end
        end
      end
      get_value("z", state)
    end

    def problem2(input)
      cin = nil
      p valid?(input)
      ops = input[:operations].dup
      (0..44).each do |i|
        num = "%02d" % i
        p "BIT: #{num}"
        x, y, z = %w[x y z].map { |c| c + num }
        if cin.nil?
          carry = ops.detect { |a| [["AND", x, y], ["AND", y, x]].include?(a[...-1]) }
          if carry.nil?
            p "ERROR carry: #{num}; didn't find"
            p ["AND", x, y]
          end
          cin = carry.last
          sum = ops.detect { |a| [["XOR", x, y, z], ["XOR", y, x, z]].include?(a) }
          if sum.nil?
            p "ERROR sum: #{num}; didn't find"
            p ["XOR", x, y, z]
          end
        else
          xorxy = ops.detect { |a| [["XOR", x, y], ["XOR", y, x]].include?(a[...-1]) }
          if xorxy.nil?
            p "ERROR xor x y: #{num}; didn't find"
            p ["XOR", x, y]
          end
          p "ERROR: unexpected #{xorxy}" if xorxy.last =~ /^[xyz]/
          if xorxy.last == "cbd"
            p "MANUAL: swap cbd to rqf"
            ops = swap_out(ops, xorxy, "rqf")
            xorxy = ops.detect { |a| [["XOR", x, y], ["XOR", y, x]].include?(a[...-1]) }
            if xorxy.nil?
              p "ERROR xor x y: #{num}; didn't find"
              p ["XOR", x, y]
            end
          end
          xorxy = xorxy.last
          sum = ops.detect { |a| [["XOR", xorxy, cin], ["XOR", cin, xorxy]].include?(a[...-1]) }
          if sum.nil?
            p "ERROR sum: #{num}; didn't find"
            p ["XOR", xorxy, cin]
          end
          if sum.last != z
            p "ERROR: expected z swapping #{z} and #{sum.last}"
            ops = swap_out(ops, sum, z)
          end
          andxy = ops.detect { |a| [["AND", x, y], ["AND", y, x]].include?(a[...-1]) }
          if andxy.nil?
            p "ERROR and x y: #{num}; didn't find"
            p ["AND", x, y]
          end
          p "ERROR: unexpected #{andxy}" if andxy.last =~ /^[xyz]/
          andxy = andxy.last
          andcin = ops.detect { |a| [["AND", cin, xorxy], ["AND", xorxy, cin]].include?(a[...-1]) }
          if andcin.nil?
            p "ERROR and x y carry: #{num}; didn't find"
            p ["AND", cin, xorxy]
          end
          p "ERROR: unexpected #{andcin}" if andcin.last =~ /^[xyz]/
          andcin = andcin.last
          carry = ops.detect { |a| [["OR", andcin, andxy], ["OR", andxy, andcin]].include?(a[...-1]) }
          if carry.nil?
            p "ERROR carry: #{num}; didn't find"
            p ["OR", andcin, andxy]
          end
          p "ERROR: unexpected #{carry}" if carry.last =~ /^[xyz]/
          cin = carry.last
        end
      end
      p valid?(input.merge(operations: ops))
    end

    def swap_out(operations, operation, out)
      target_op = operations.detect { |a| a.last == out }
      this_op = [*operation[...-1], out]

      p [operation, this_op]
      operations.map do |op|
        if op == operation
          p ["replace", op, this_op]
          this_op
        elsif op == target_op
          p ["replace", op, [*op[...3], operation[3]]]
          [*op[...3], operation[3]]
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

    def valid?(input)
      state = input[:state].dup
      bits = state.keys.grep(/^x/).size
      max_val = bits.times.sum { |i| 1 << i }
      bits.times.flat_map do |i|
        val = 1 << i
        set_value("x", val, state)
        set_value("y", 0, state)
        res1 = problem1(input.merge(state:))
        set_value("x", val, state)
        set_value("y", max_val, state)
        res2 = problem1(input.merge(state:))
        set_value("y", val, state)
        set_value("x", 0, state)
        res3 = problem1(input.merge(state:))
        set_value("y", val, state)
        set_value("x", max_val, state)
        res4 = problem1(input.merge(state:))
        [res1 == val, res2 == max_val + val, res3 == val, res4 == max_val + val]
      end.all?
    end
  end
end
