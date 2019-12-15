class Intcode
  attr_reader :prg, :index

  def initialize(prog: , input: [], output: [], index: 0, halt: false, relative_base: 0)
    @prg = prog.dup
    @input = input
    @output = output
    @index = index
    @halt = halt
    @relative_base = relative_base
  end

  def clone
    Intcode.new(prog: @prg, input: @input.dup, output: @output.dup, index: @index, halt: @halt, relative_base: @relative_base)
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

class Droid
  attr_accessor :x, :y, :x_next, :y_next, :active
  attr_reader :input, :intcode

  def initialize(intcode:, input:, x:, y:, x_next:, y_next:)
    @intcode = intcode
    @input = input
    @x = x
    @y = y
    @x_next = x_next
    @y_next = y_next
    @active = true
  end

  def to_s
    "Droid: x=#{x}; y=#{y}; x_next=#{x_next}; y_next=#{y_next}; input=#{input}"
  end

  def inspect
    "Droid: x=#{x}; y=#{y}; x_next=#{x_next}; y_next=#{y_next}; input=#{input}"
  end
end

def draw_map(prog)
  x_min, y_min = Array.new(4, 0)
  map = [[1]]
  droids = Array.new(4) do |index|
    input = index + 1
    x_next, y_next = next_coords(input, 0, 0)
    intcode = Intcode.new(prog: prog, input: [input])
    Droid.new(
      intcode: intcode,
      input: input,
      x: 0,
      y: 0,
      x_next: x_next,
      y_next: y_next,
    )
  end
  while droids.any?(&:active)
    new_droids = []
    droids.each do |droid|
      next unless droid.active

      droid.intcode.compute_continue
      output = droid.intcode.output
      # puts droid.intcode.output
      map, x_min, y_min = fit_map(output, map, droid.x_next, droid.y_next, x_min, y_min)
      case output
      when 0
        # puts "0. x=#{droid.x}; y=#{droid.y}; x_next=#{droid.x_next}; y_next=#{droid.y_next}; map=#{map.inspect}"
        droid.active = false
        next
      when 1, 2
        # puts "#{output}. x=#{droid.x}; y=#{droid.y}; x_next=#{droid.x_next}; y_next=#{droid.y_next}; map=#{map.inspect}"
        x_next, y_next = next_coords(droid.input, droid.x_next, droid.y_next)
        droid.x = droid.x_next
        droid.y = droid.y_next
        droid.x_next = x_next
        droid.y_next = y_next
      else
        raise "ERROR"
      end
      Array.new(4) do |index|
        input = index + 1
        next if input == droid.input
        x_next, y_next = next_coords(input, droid.x, droid.y)
        # puts "x_min=#{x_min}; y_min=#{y_min}; x=#{droid.x}; y=#{droid.y}; x_next=#{x_next}; y_next=#{y_next}; map=#{map.inspect}"
        next if x_next >=  x_min && y_next >= y_min && y_next < map.length + y_min && !map[y_next-y_min][x_next-x_min].nil?
        new_droid = Droid.new(
          intcode: droid.intcode.clone,
          input: input,
          x: droid.x,
          y: droid.y,
          x_next: x_next,
          y_next: y_next,
        )
        new_droid.intcode.input(input)
        new_droids.push(new_droid)
      end
      droid.intcode.input(droid.input)
    end
    droids += new_droids
    # puts droids.inspect
    plot(map)
    puts
    sleep 0.1
  end
end

def fit_map(val, map, x, y, x_min, y_min)
  if x < x_min
    map = map.map { |line| line.unshift(nil) }
    x_min = x
  end
  if y < y_min
    map.unshift([])
    y_min = y
  end
  if y >= map.length + y_min
    map.push([])
  end
  # puts "x=#{x}; y=#{y}; x_min=#{x_min}; y_min=#{y_min}; map=#{map.inspect}"
  map[y - y_min][x - x_min] = val
  [map, x_min, y_min]
end

def next_coords(input, x, y)
  [
    input == 4 ? x+1 : (input == 3 ? x-1 : x),
    input == 2 ? y+1 : (input == 1 ? y-1 : y),
  ]
end

def plot(map)
  map.each do |line|
    str = line.map do |pt|
      case pt
      when nil
        " "
      when 0
        "#"
      when 1
        "."
      when 2
        "O"
      else
        raise "ERROR"
      end
    end
    puts str.join
  end
end
