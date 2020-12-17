def init_field(input, cycles)
  diff = cycles + 1
  init_field = input.split("\n").reject(&:empty?).map do |line|
    Array.new(diff, 0) + line.chars.map { |c| c == "#" ? 1 : 0 } + Array.new(diff, 0)
  end
  init_field = Array.new(diff) { Array.new(init_field.first.length, 0) } +
    init_field + Array.new(diff) { Array.new(init_field.first.length, 0) }
  Array.new(diff) { Array.new(init_field.length) { Array.new(init_field.first.length, 0) } } +
    [init_field] +
    Array.new(diff) { Array.new(init_field.length) { Array.new(init_field.first.length, 0) } }
end

def init_field4(input, cycles)
  diff = cycles + 1
  i_field = init_field(input, cycles)
  Array.new(diff) { Array.new(i_field.length) { Array.new(i_field.first.length) { Array.new(i_field.first.first.length, 0) } } } +
    [i_field] +
    Array.new(diff) { Array.new(i_field.length) { Array.new(i_field.first.length) { Array.new(i_field.first.first.length, 0) } } }
end

def cycle(field)
  new_field = Array.new(field.length) do
    Array.new(field.first.length) { Array.new(field.first.first.length, 0) }
  end
  (1..(field.length-2)).each do |z|
    (1..(field[z].length-2)).each do |y|
      (1..(field[z][y].length-2)).each do |x|
        neighbours = field[z][y][x-1] +
          field[z][y][x+1] +
          field[z][y-1][x-1] +
          field[z][y+1][x-1] +
          field[z][y-1][x+1] +
          field[z][y+1][x+1] +
          field[z-1][y][x-1] +
          field[z+1][y][x-1] +
          field[z-1][y][x+1] +
          field[z+1][y][x+1] +
          field[z][y-1][x] +
          field[z][y+1][x] +
          field[z-1][y-1][x] +
          field[z+1][y-1][x] +
          field[z-1][y+1][x] +
          field[z+1][y+1][x] +
          field[z-1][y][x] +
          field[z+1][y][x] +
          field[z-1][y-1][x-1] +
          field[z+1][y-1][x-1] +
          field[z-1][y+1][x-1] +
          field[z+1][y+1][x-1] +
          field[z-1][y-1][x+1] +
          field[z+1][y-1][x+1] +
          field[z-1][y+1][x+1] +
          field[z+1][y+1][x+1]
        new_field[z][y][x] = if field[z][y][x] == 1
          (2..3).include?(neighbours) ? 1 : 0
        else
          neighbours == 3 ? 1 : 0
        end
      end
    end
  end
  new_field
end

def cycle4(field)
  new_field = Array.new(field.length) do
    Array.new(field.first.length) { Array.new(field.first.first.length) { Array.new(field.first.first.first.length, 0) } }
  end
  (1..(field.length-2)).each do |w|
    (1..(field[w].length-2)).each do |z|
      (1..(field[w][z].length-2)).each do |y|
        (1..(field[w][z][y].length-2)).each do |x|
          neighbours =
            field[w-1][z][y][x] +
            field[w+1][z][y][x] +
            field[w][z][y][x-1] +
            field[w][z][y][x+1] +
            field[w][z][y-1][x-1] +
            field[w][z][y+1][x-1] +
            field[w][z][y-1][x+1] +
            field[w][z][y+1][x+1] +
            field[w][z-1][y][x-1] +
            field[w][z+1][y][x-1] +
            field[w][z-1][y][x+1] +
            field[w][z+1][y][x+1] +
            field[w][z][y-1][x] +
            field[w][z][y+1][x] +
            field[w][z-1][y-1][x] +
            field[w][z+1][y-1][x] +
            field[w][z-1][y+1][x] +
            field[w][z+1][y+1][x] +
            field[w][z-1][y][x] +
            field[w][z+1][y][x] +
            field[w][z-1][y-1][x-1] +
            field[w][z+1][y-1][x-1] +
            field[w][z-1][y+1][x-1] +
            field[w][z+1][y+1][x-1] +
            field[w][z-1][y-1][x+1] +
            field[w][z+1][y-1][x+1] +
            field[w][z-1][y+1][x+1] +
            field[w][z+1][y+1][x+1] +
            field[w-1][z][y][x-1] +
            field[w-1][z][y][x+1] +
            field[w-1][z][y-1][x-1] +
            field[w-1][z][y+1][x-1] +
            field[w-1][z][y-1][x+1] +
            field[w-1][z][y+1][x+1] +
            field[w-1][z-1][y][x-1] +
            field[w-1][z+1][y][x-1] +
            field[w-1][z-1][y][x+1] +
            field[w-1][z+1][y][x+1] +
            field[w-1][z][y-1][x] +
            field[w-1][z][y+1][x] +
            field[w-1][z-1][y-1][x] +
            field[w-1][z+1][y-1][x] +
            field[w-1][z-1][y+1][x] +
            field[w-1][z+1][y+1][x] +
            field[w-1][z-1][y][x] +
            field[w-1][z+1][y][x] +
            field[w-1][z-1][y-1][x-1] +
            field[w-1][z+1][y-1][x-1] +
            field[w-1][z-1][y+1][x-1] +
            field[w-1][z+1][y+1][x-1] +
            field[w-1][z-1][y-1][x+1] +
            field[w-1][z+1][y-1][x+1] +
            field[w-1][z-1][y+1][x+1] +
            field[w-1][z+1][y+1][x+1] +
            field[w+1][z][y][x-1] +
            field[w+1][z][y][x+1] +
            field[w+1][z][y-1][x-1] +
            field[w+1][z][y+1][x-1] +
            field[w+1][z][y-1][x+1] +
            field[w+1][z][y+1][x+1] +
            field[w+1][z-1][y][x-1] +
            field[w+1][z+1][y][x-1] +
            field[w+1][z-1][y][x+1] +
            field[w+1][z+1][y][x+1] +
            field[w+1][z][y-1][x] +
            field[w+1][z][y+1][x] +
            field[w+1][z-1][y-1][x] +
            field[w+1][z+1][y-1][x] +
            field[w+1][z-1][y+1][x] +
            field[w+1][z+1][y+1][x] +
            field[w+1][z-1][y][x] +
            field[w+1][z+1][y][x] +
            field[w+1][z-1][y-1][x-1] +
            field[w+1][z+1][y-1][x-1] +
            field[w+1][z-1][y+1][x-1] +
            field[w+1][z+1][y+1][x-1] +
            field[w+1][z-1][y-1][x+1] +
            field[w+1][z+1][y-1][x+1] +
            field[w+1][z-1][y+1][x+1] +
            field[w+1][z+1][y+1][x+1]
          new_field[w][z][y][x] = if field[w][z][y][x] == 1
            (2..3).include?(neighbours) ? 1 : 0
          else
            neighbours == 3 ? 1 : 0
          end
        end
      end
    end
  end
  new_field
end

def count(field)
  field.inject(0) do |sum, plane|
    plane.inject(sum) do |sum, line|
      sum + line.inject(&:+)
    end
  end
end

def count4(field4)
  field4.inject(0) do |sum, field|
    field.inject(sum) do |sum, plane|
      plane.inject(sum) do |sum, line|
        sum + line.inject(&:+)
      end
    end
  end
end
