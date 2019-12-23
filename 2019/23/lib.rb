class Intcode
  attr_reader :prg, :index

  def initialize(prog: , input: [])
    @input = input
    @prg = prog.dup
    @index = 0
    @halt = false
    @output = []
    @relative_base = 0
  end

  def halt?
    @halt
  end

  def input(data)
    @input.push(data)
  end

  def bulk_input(arr)
    @input += arr
  end

  def output
    @output.shift
  end

  def flush_output
    re = @output
    @output = []
    re
  end

  def compute_continue
    while !halt? do
      code = @prg[@index] % 100
      modes = [100, 1000, 10000].map { |pos| @prg[@index] / pos % 10 }
      case code
      when 1
        @prg[address(@index+3, modes[2])] = param(@index+1, modes[0]) + param(@index+2, modes[1])
        @index += 4
      when 2
        @prg[address(@index+3, modes[2])] = param(@index+1, modes[0]) * param(@index+2, modes[1])
        @index += 4
      when 3
        data = @input.shift
        return if data.nil?
        @prg[address(@index+1, modes[0])] = data
        @index += 2
      when 4
        @output.push(param(@index+1, modes[0]))
        @index += 2
      when 5
        if param(@index+1, modes[0]) != 0
          @index = param(@index+2, modes[1])
        else
          @index += 3
        end
      when 6
        if param(@index+1, modes[0]) == 0
          @index = param(@index+2, modes[1])
        else
          @index += 3
        end
      when 7
        if param(@index+1, modes[0]) < param(@index+2, modes[1])
          @prg[address(@index+3, modes[2])] = 1
        else
          @prg[address(@index+3, modes[2])] = 0
        end
        @index += 4
      when 8
        if param(@index+1, modes[0]) == param(@index+2, modes[1])
          @prg[address(@index+3, modes[2])] = 1
        else
          @prg[address(@index+3, modes[2])] = 0
        end
        @index += 4
      when 9
        @relative_base += param(@index+1, modes[0])
        @index += 2
      when 99
        @halt = true
      else
        raise "ERROR"
      end
    end
  end

  def param(index, mode)
    value = @prg[index] || 0
    case mode
    when 0
      @prg[value] || 0
    when 1
      value
    when 2
      @prg[value + @relative_base] || 0
    else
      raise "ERROR"
    end
  end

  def address(index, mode)
    value = @prg[index] || 0
    case mode
    when 0
      value
    when 2
      value + @relative_base
    else
      raise "ERROR"
    end
  end
end

class IntcodeNetwork
  def initialize(prog:)
    @computers = Array.new(50) { |i| Intcode.new(prog: prog, input: [i]) }
    @nat = nil
    @last_nat_y = nil
  end

  def run(p1: false)
    while true
      packets = @computers.each_with_object({}) do |computer, traffic|
        computer.compute_continue
        out = computer.flush_output
        next if out.empty?
        out.each_slice(3) do |packet|
          if packet[0] == 255
            return packet[2] if p1
            @nat = packet[1..2]
          else
            traffic[packet[0]] ||= []
            traffic[packet[0]] += packet[1..2]
          end
        end
      end
      if packets.empty? && @nat && !@nat.empty?
        return @last_nat_y if @last_nat_y == @nat[1]
        @computers[0].bulk_input(@nat)
        @last_nat_y = @nat[1]
      else
        @computers.each_with_index do |computer, address|
          if packets[address]
            computer.bulk_input(packets[address])
          else
            computer.input(-1)
          end
        end
      end
    end
  end
end
