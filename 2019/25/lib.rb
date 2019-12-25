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

class DroidControl
  def initialize(prog:, all: false)
    pickup = all ? pickup_all : pickup_correct
    @intcode = Intcode.new(prog: prog, input: pickup.chars.map(&:ord))
  end

  def pickup_all
    input = <<PICKUP
east
take jam
east
take fuel cell
west
south
take shell
north
west
south
west
take easter egg
north
east
take space heater
west
south
west
west
take monolith
south
west
north
take coin
south
east
north
west
take mug
north
PICKUP
  end

  def pickup_correct
    input = <<PICKUP
east
east
take fuel cell
west
south
take shell
north
west
south
west
north
east
take space heater
west
south
west
west
south
west
north
take coin
south
east
north
west
north
PICKUP
  end

  def pass_security_check
    @intcode.flush_output
    check = "north\n"
    items = [
      "coin",
      "easter egg",
      "monolith",
      "jam",
      "mug",
      "shell",
      "space heater",
      "fuel cell",
    ]
    (1..(items.length - 1)).to_a.reverse.each do |num|
      items.combination(num).each do |comb|
        diff = items - comb
        input = diff.map { |item| "drop #{item}\n" }.join + check
        @intcode.bulk_input(input.chars.map(&:ord))
        @intcode.compute_continue
        return comb unless @intcode.flush_output.map(&:chr).join.match?(/Droids on this ship are (lighter|heavier)/)
        input = diff.map { |item| "take #{item}\n" }.join
        @intcode.bulk_input(input.chars.map(&:ord))
      end
    end
    raise "FAILED"
  end
  def run
    while true
      @intcode.compute_continue
      puts
      puts @intcode.flush_output.map(&:chr).join
      puts
      print "> "
      @intcode.bulk_input(gets.chars.map(&:ord))
    end
  end
end
