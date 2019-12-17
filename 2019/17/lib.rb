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

def to_lines(output)
  len = output.index(10)
  output.each_slice(len+1).map { |line| line[0...-1] }
end

def alignment(output)
  lines = to_lines(output)
  (1..(lines.length-2)).inject(0) do |algnmnt, y|
    (1..(lines[y].length-1)).inject(algnmnt) do |a, x|
      if lines[y][x] == 35 && lines[y-1][x] == 35 && lines[y+1][x] == 35 && lines[y][x-1] == 35 && lines[y][x+1] == 35
        a + x * y
      else
        a
      end
    end
  end
end

SCAFFOLD = %w[^ v < > #].map(&:ord)

def trajectory(output)
  lines = to_lines(output)
  robot = %w[^ v < >].map(&:ord)
  y = lines.index { |line| robot.any? { |r| line.include?(r) } }
  x = lines[y].index { |char| robot.include?(char) }
  dir = robot.index(lines[y][x])
  traj = []
  while lines.any? { |line| line.any? { |c| c == "#".ord } } do
    case dir
    when 0
      if y > 0 && SCAFFOLD.include?(lines[y-1][x])
        traj[-1] += 1
        lines[y][x] = robot[dir]
        y -= 1
      elsif x > 0 && SCAFFOLD.include?(lines[y][x-1])
        dir = 2
        traj += ["L", 0]
      elsif x < lines[y].length - 1 && SCAFFOLD.include?(lines[y][x+1])
        dir = 3
        traj += ["R", 0]
      else
        return traj
      end
    when 1
      if y < lines.length - 1 && SCAFFOLD.include?(lines[y+1][x])
        traj[-1] += 1
        lines[y][x] = robot[dir]
        y += 1
      elsif x > 0 && SCAFFOLD.include?(lines[y][x-1])
        dir = 2
        traj += ["R", 0]
      elsif x < lines[y].length - 1 && SCAFFOLD.include?(lines[y][x+1])
        dir = 3
        traj += ["L", 0]
      else
        return traj
      end
    when 2
      if x > 0 && SCAFFOLD.include?(lines[y][x-1])
        traj[-1] += 1
        lines[y][x] = robot[dir]
        x -= 1
      elsif y > 0 && SCAFFOLD.include?(lines[y-1][x])
        dir = 0
        traj += ["R", 0]
      elsif y < lines.length - 1 && SCAFFOLD.include?(lines[y+1][x])
        dir = 1
        traj += ["L", 0]
      else
        return traj
      end
    when 3
      if x < lines[y].length - 1 && SCAFFOLD.include?(lines[y][x+1])
        traj[-1] += 1
        lines[y][x] = robot[dir]
        x += 1
      elsif y > 0 && SCAFFOLD.include?(lines[y-1][x])
        dir = 0
        traj += ["L", 0]
      elsif y < lines.length - 1 && SCAFFOLD.include?(lines[y+1][x])
        dir = 1
        traj += ["R", 0]
      else
        return traj
      end
    else
      raise "ERROR"
    end
  end
  traj
end

def find_functions_input(traj)
  a = ""
  b = ""
  c = ""
  prog = traj.join
  (4..20).each do |a_length|
    a = prog[0...a_length]
    bcs = prog.split(a)
    bcs.each do |bc|
      (4..20).each do |b_length|
        b = bc[0...b_length]
        cs = bc.split(b)
        cs.each do |c|
          if prog.split(a).map { |pcs| pcs.split(b).map { |pcs1| pcs1.split(c) } }.flatten.empty?
            prog = prog.gsub(a, "A").gsub(b, "B").gsub(c, "C")
            return ([prog.chars.join(",")] +
              [a, b, c].map { |sr| sr.gsub(/([0-9])([RL])/, '\1,\2').gsub(/([RL])([0-9])/, '\1,\2') }).join("\n")
          end
        end
      end
    end
  end
  raise "ERROR"
end
