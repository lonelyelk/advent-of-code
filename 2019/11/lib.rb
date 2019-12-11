def robot_pos_change(pos, dir)
  x, y, face = pos
  case face
  when "^"
    case dir
    when 1
      [x+1, y, ">"]
    when 0
      [x-1, y, "<"]
    else
      raise "ERROR"
    end
  when ">"
    case dir
    when 1
      [x, y+1, "v"]
    when 0
      [x, y-1, "^"]
    else
      raise "ERROR"
    end
  when "v"
    case dir
    when 1
      [x-1, y, "<"]
    when 0
      [x+1, y, ">"]
    else
      raise "ERROR"
    end
  when "<"
    case dir
    when 1
      [x, y-1, "^"]
    when 0
      [x, y+1, "v"]
    else
      raise "ERROR"
    end
  else
    raise "ERROR"
  end
end

class Intcode
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

def run(prog, start_color = 0)
  intcode = Intcode.new(prog: prog)
  pos = [0, 0, "^"]
  history = []
  while !intcode.halt?
    intcode.compute_continue
    arr = intcode.flush_output
    if arr.length > 2
      raise "ERROR"
    end
    color, dir = arr
    if color && dir
      pos.push(color)
      history.push(pos)
      pos = robot_pos_change(pos, dir)
    end
    intcode.input(((history.reverse + [[0, 0, "^", start_color]]).detect do |point|
      point[0..1] == pos[0..1]
    end || [])[3] || 0)
  end
  history
end

def plot(history)
  image = ['#']
  x_min = 0
  x_max = 0
  y_min = 0
  y_max = 0
  history.each do |point|
    x, y, _, color = point
    if y < y_min || y > y_max
      line = Array.new(x_max - x_min + 1) { |i| x == i - x_min && color == 1 ? '#' : ' ' }.join
      if y < y_min
        y_min = y
        image = [line] + image
      else
        y_max = y
        image.push(line)
      end
    elsif x < x_min
      x_min = x
      image = image.map.with_index { |line, i| "#{y == i - y_min && color == 1 ? '#' : ' '}#{line}" }
    elsif x > x_max
      x_max = x
      image = image.map.with_index { |line, i| "#{line}#{y == i - y_min && color == 1 ? '#' : ' '}" }
    else
      image[y - y_min] = image[y - y_min][0...(x - x_min)] + (color == 1 ? '#' : ' ') + image[y - y_min][(x - x_min + 1)..-1]
    end
  end
  image
end
