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

def plot(arr, screen, score)
  screen_memory = []
  score ||= 0
  arr.each_slice(3) do |point|
    if point[0..1] == [-1, 0]
      score = point[2]
      next
    end
    screen_memory[point[1]] ||= []
    screen_memory[point[1]][point[0]] = point[2]
  end
  if screen.nil?
    puts score
    screen = screen_memory.map do |row|
      row.map { |char| convert_char(char) }.join
    end
  else
    puts "\033[25A"
    puts score
    screen_memory.each_with_index do |row, y|
      next if row.nil?
      row.each_with_index do |char, x|
        next if char.nil?
        screen[y] = screen[y][0...x] + convert_char(char) + screen[y][(x+1)..-1]
      end
    end
  end
  screen.each { |row| puts row }
  [screen, score]
end

def convert_char(char)
  case char
  when 0
    ' '
  when 1
    '#'
  when 2
    '.'
  when 3
    '-'
  when 4
    'o'
  else
    raise "ERROR"
  end
end
