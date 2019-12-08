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

def compute(prg_src, input)
  prg = prg_src.dup
  output = []
  index = 0

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
