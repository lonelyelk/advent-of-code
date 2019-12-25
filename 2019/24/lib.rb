class GameOfLife
  attr_reader :bd_rating
  def initialize(input)
    @field = Array.new(input.length) do |y|
      input[y].map { |c| c == "#" ? 1 : 0 }
    end
    @fields = {0 => @field}
    @portal_y = @field.length / 2
    @portal_x = @field.first.length / 2
    @bd_rating = []
    save_bd!
  end

  def empty_field
    @field.map do |line|
      Array.new(line.length, 0)
    end
  end

  def step
    @field = @field.map.with_index do |line, y|
      line.map.with_index do |c, x|
        if c > 0
          count_around(x, y) == 1 ? 1 : 0
        else
          count_around(x, y).between?(1, 2) ? 1 : 0
        end
      end
    end
    save_bd!
  end

  def save_bd!
    r = 1
    bd_r = 0
    @field.each do |line|
      line.each do |c|
        bd_r += r if c > 0
        r <<= 1
      end
    end
    @bd_rating.push(bd_r)
  end

  def count_around(x, y)
    if y == 0 && x == 0
      @field[y+1][x] + @field[y][x+1]
    elsif y == 0 && x == @field.first.length - 1
      @field[y+1][x] + @field[y][x-1]
    elsif y == 0
      @field[y+1][x] + @field[y][x+1] + @field[y][x-1]
    elsif x == 0 && y == @field.length - 1
      @field[y][x+1] + @field[y-1][x]
    elsif x == 0
      @field[y+1][x] + @field[y][x+1] + @field[y-1][x]
    elsif x == @field.first.length - 1 && y == @field.length - 1
      @field[y-1][x] + @field[y][x-1]
    elsif y == @field.length - 1
      @field[y-1][x] + @field[y][x+1] + @field[y][x-1]
    elsif x == @field.first.length - 1
      @field[y+1][x] + @field[y][x-1] + @field[y-1][x]
    else
      @field[y+1][x] + @field[y][x-1] + @field[y-1][x] + @field[y][x+1]
    end
  end

  def step_recursive(n)
    n.times do
      new_fields = {}
      @fields.each do |level, field|
        @field = field
        new_fields[level] = field.map.with_index do |line, y|
          line.map.with_index do |c, x|
            if c > 0
              count_around_recursive(x, y, level) == 1 ? 1 : 0
            else
              count_around_recursive(x, y, level).between?(1, 2) ? 1 : 0
            end
          end
        end
      end
      out_level, in_level = @fields.keys.minmax
      @field = empty_field
      unless @fields[out_level].all? { |line| line.all? { |c| c == 0 } }
        new_fields[out_level-1] = empty_field.map.with_index do |line, y|
          line.map.with_index do |_, x|
            count_around_recursive(x, y, out_level-1).between?(1, 2) ? 1 : 0
          end
        end
      end
      unless @fields[in_level].all? { |line| line.all? { |c| c == 0 } }
        new_fields[in_level+1] = empty_field.map.with_index do |line, y|
          line.map.with_index do |_, x|
            count_around_recursive(x, y, in_level+1).between?(1, 2) ? 1 : 0
          end
        end
      end
      @fields = new_fields
    end
  end

  def count_around_recursive(x, y, level)
    out_field = @fields[level - 1] || empty_field
    in_field = @fields[level + 1] || empty_field
    in_field_left, in_field_right = in_field.map { |line| [line.first, line.last] }.inject([0, 0]) { |acc, l| [acc.first + l.first, acc.last + l.last] }
    in_field_top, in_field_bottom = [in_field.first, in_field.last].map { |line| line.inject(&:+) }
    if y == 0 && x == 0
      @field[y+1][x] + @field[y][x+1] + out_field[@portal_y-1][@portal_x] + out_field[@portal_y][@portal_x-1]
    elsif y == 0 && x == @field.first.length - 1
      @field[y+1][x] + @field[y][x-1] + out_field[@portal_y-1][@portal_x] + out_field[@portal_y][@portal_x+1]
    elsif y == 0
      @field[y+1][x] + @field[y][x+1] + @field[y][x-1] + out_field[@portal_y-1][@portal_x]
    elsif x == 0 && y == @field.length - 1
      @field[y][x+1] + @field[y-1][x] + out_field[@portal_y+1][@portal_x] + out_field[@portal_y][@portal_x-1]
    elsif x == 0
      @field[y+1][x] + @field[y][x+1] + @field[y-1][x] + out_field[@portal_y][@portal_x-1]
    elsif x == @field.first.length - 1 && y == @field.length - 1
      @field[y-1][x] + @field[y][x-1] + out_field[@portal_y+1][@portal_x] + out_field[@portal_y][@portal_x+1]
    elsif y == @field.length - 1
      @field[y-1][x] + @field[y][x+1] + @field[y][x-1] + out_field[@portal_y+1][@portal_x]
    elsif x == @field.first.length - 1
      @field[y+1][x] + @field[y][x-1] + @field[y-1][x] + out_field[@portal_y][@portal_x+1]
    elsif y == @portal_y && x == @portal_x - 1
      @field[y+1][x] + @field[y][x-1] + @field[y-1][x] + in_field_left
    elsif y == @portal_y && x == @portal_x + 1
      @field[y+1][x] + @field[y][x+1] + @field[y-1][x] + in_field_right
    elsif x == @portal_x && y == @portal_y - 1
      @field[y-1][x] + @field[y][x-1] + @field[y][x+1] + in_field_top
    elsif x == @portal_x && y == @portal_y + 1
      @field[y][x-1] + @field[y+1][x] + @field[y][x+1] + in_field_bottom
    elsif x == @portal_x && y == @portal_y
      0
    else
      @field[y+1][x] + @field[y][x-1] + @field[y-1][x] + @field[y][x+1]
    end
  end

  def count_bugs
    @fields.inject(0) do |count, (_, field)|
      count + field.inject(0) do |acc, line|
        acc + line.count { |c| c > 0 }
      end
    end
  end

  def to_s
    @field.map do |line|
      line.map { |c| c > 0 ? "#" : "." }.join
    end.join("\n")
  end
end

def bd_rating_for_twice(input)
  gol = GameOfLife.new(input)
  while gol.bd_rating.index(gol.bd_rating.last) == gol.bd_rating.length - 1
    gol.step
  end
  gol.bd_rating.last
end

def count_bugs_in_recursive_steps(input, n)
  gol = GameOfLife.new(input)
  gol.step_recursive(n)
  gol.count_bugs
end
