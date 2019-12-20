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

def scan(prog)
  count = 0
  (0...50).each do |y|
    (0...50).each do |x|
      if beam?(prog, x, y)
        print "#"
        count += 1
      else
        print "."
      end
    end
    puts
  end
  count
end

def scan2(prog, xx, yy)
  count = 0
  counts = 0
  ((yy-10)...(yy+110)).each do |y|
    ((xx-10)...(xx+110)).each do |x|
      if beam?(prog, x, y)
        santa = x.between?(xx, xx+99) && y.between?(yy, yy+99)
        print santa ? "O" : "#"
        count += 1
        counts += 1 if santa
      else
        print "."
      end
    end
    puts
  end
  counts
end

def santa_fit(prog, x1, y)
  x = x1
  x2 = x1
  beam = beam?(prog, x, y)
  beam_ended = false
  beam_started = beam
  beam_width = 0
  while !beam_ended
    beam_width += 1 if beam
    new_x = x + 1
    new_beam = beam?(prog, new_x, y)
    if new_beam
      beam_started = true
      x = new_x
      beam = new_beam
      x2 = new_x if !beam && new_beam
    elsif beam_started
      beam_ended = true
    else
      x = new_x
    end
  end
  if beam_width < 100
    return [-1, x2]
  end
  beam_ended = false
  beam_height = 0
  beam = beam?(prog, x, y)
  while !beam_ended && beam_height < 100
    beam_height += 1
    new_y = y + beam_height
    new_beam = beam?(prog, x, new_y)
    if new_beam
      beam = new_beam
    else
      beam_ended = true
    end
  end
  if beam_height < 100
    return [-1, x2]
  end
  y1 = y + beam_height - 1
  beam_ended = false
  beam_width = 0
  while !beam_ended
    beam_width += 1
    new_x = x - 1
    new_beam = beam?(prog, new_x, y1)
    if new_beam
      x = new_x
      beam = new_beam
    else
      beam_ended = true
    end
  end
  if beam_width < 100
    [-1, x2]
  elsif beam_width > 100
    [1, x2]
  else
    [0, x]
  end
end

def beam?(prog, x, y)
  intcode = Intcode.new(prog: prog)
  intcode.input(x)
  intcode.input(y)
  intcode.compute_continue
  intcode.output == 1
end

def find_santa_fit(prog)
  x1 = 9
  x2 = 9
  y1 = 13
  y2 = 0
  cmp, x1 = santa_fit(prog, x1, y1)
  while cmp != 0
    if cmp < 0
      y1, y2 = [y1*2, y1]
    else
      y1 = (y1 - y2) / 2 + y2
      x1 = x2
    end
    # puts "X: #{x1}; Y: #{y1}"
    cmp, x2 = santa_fit(prog, x1, y1)
  end
  x1 = x2 - 50
  x0 = x2
  while cmp == 0
    y2 = y1 - 1
    cmp, x2 = santa_fit(prog, x1, y2)
    # puts "X: #{x2}; Y: #{y2}; cmp: #{cmp}"
    if cmp == 0
      x0 = x2
      x1 = x2 - 50
      y1 = y2
    end
  end
  pos = x0 * 10000 + y1
  20.times do |i|
    cmp, x2 = santa_fit(prog, x0 - i - 50, y1 - i)
    if cmp == 0
      pos = x2 * 10000 + y1 - i
    end
    # puts "crawl: X: #{x2}; Y: #{y1 - i}; cmp: #{cmp}"
  end
  pos
end
