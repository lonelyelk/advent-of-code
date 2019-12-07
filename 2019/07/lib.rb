
def param(prg, index, mode)
    case mode
    when 0
        prg[prg[index]]
    when 1
        prg[index]
    else
        raise "ERROR"
    end
end

def compute(prg, input)
  index = 0
  output = []

  while prg[index] != 99 do
    code = prg[index] % 100
    modes = [100, 1000, 10000].map { |pos| prg[index] / pos % 10 }
    case code
    when 1
      prg[prg[index+3]] = param(prg, index+1, modes[0]) + param(prg, index+2, modes[1])
      index += 4
    when 2
      prg[prg[index+3]] = param(prg, index+1, modes[0]) * param(prg, index+2, modes[1])
      index += 4
    when 3
      data = input.shift
      raise "ERROR" if data.nil?
      prg[prg[index+1]] = data
      index += 2
    when 4
      output.push(param(prg, index+1, modes[0]))
      index += 2
    when 5
      if param(prg, index+1, modes[0]) != 0
        index = param(prg, index+2, modes[1])
      else
        index += 3
      end
    when 6
      if param(prg, index+1, modes[0]) == 0
        index = param(prg, index+2, modes[1])
      else
        index += 3
      end
    when 7
      if param(prg, index+1, modes[0]) < param(prg, index+2, modes[1])
        prg[prg[index+3]] = 1
      else
        prg[prg[index+3]] = 0
      end
      index += 4
    when 8
      if param(prg, index+1, modes[0]) == param(prg, index+2, modes[1])
        prg[prg[index+3]] = 1
      else
        prg[prg[index+3]] = 0
      end
      index += 4
    when 99
      break
    else
      raise "ERROR"
    end
  end
  output
end

def thruster_signal(prg, phase_setting)
  phase_setting.inject(0) do |input, setting|
    out = compute(prg.dup, [setting, input])
    out[0]
  end
end

def max_thruster_signal(prg)
  res = []
  [0, 1, 2, 3, 4].permutation do |setting|
    res.push(thruster_signal(prg, setting))
  end
  res.max
end

def feedback_thruster_signal(prg, phase_setting)
  amplifiers = Array.new(5) do |i|
    Amplifier.new(prg, phase_setting[i])
  end
  output = amplifiers.inject(0) do |out, a|
    unless a.halt?
      a.input(out)
      a.compute_continue
      a.output
    end
  end
  while !amplifiers.all?(&:halt?)
    output = amplifiers.inject(output) do |out, a|
      unless a.halt?
        a.input(out)
        a.compute_continue
        a.output
      end
    end
  end
  output
end

def max_feedback_thruster_signal(prg)
  res = []
  [5, 6, 7, 8, 9].permutation do |setting|
    res.push(feedback_thruster_signal(prg, setting))
  end
  res.max
end

class Amplifier
  attr_reader :index, :prg

  def initialize(prg, setting)
    @input = [setting]
    @prg = prg.dup
    @index = 0
    @halt = false
    @output = []
  end

  def halt?
    @halt
  end

  def input(data)
    @input.push(data)
  end

  def output
    @output.shift
  end

  def compute_continue
    while !halt? do
      code = @prg[@index] % 100
      modes = [100, 1000, 10000].map { |pos| @prg[@index] / pos % 10 }
      case code
      when 1
        @prg[@prg[@index+3]] = param(@prg, @index+1, modes[0]) + param(@prg, @index+2, modes[1])
        @index += 4
      when 2
        @prg[@prg[@index+3]] = param(@prg, @index+1, modes[0]) * param(@prg, @index+2, modes[1])
        @index += 4
      when 3
        data = @input.shift
        return if data.nil?
        @prg[@prg[@index+1]] = data
        @index += 2
      when 4
        @output.push(param(@prg, @index+1, modes[0]))
        @index += 2
      when 5
        if param(@prg, @index+1, modes[0]) != 0
          @index = param(@prg, @index+2, modes[1])
        else
          @index += 3
        end
      when 6
        if param(@prg, @index+1, modes[0]) == 0
          @index = param(@prg, @index+2, modes[1])
        else
          @index += 3
        end
      when 7
        if param(@prg, @index+1, modes[0]) < param(@prg, @index+2, modes[1])
          @prg[@prg[@index+3]] = 1
        else
          @prg[@prg[@index+3]] = 0
        end
        @index += 4
      when 8
        if param(@prg, @index+1, modes[0]) == param(@prg, @index+2, modes[1])
          @prg[@prg[@index+3]] = 1
        else
          @prg[@prg[@index+3]] = 0
        end
        @index += 4
      when 99
        @halt = true
      else
        raise "ERROR"
      end
    end
  end
end
