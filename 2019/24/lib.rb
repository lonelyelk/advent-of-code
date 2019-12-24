class GameOfLife
  attr_reader :bd_rating
  def initialize(input)
    @field = Array.new(input.length) do |y|
      input[y].map { |c| c == "#" ? 1 : 0 }
    end
    @bd_rating = []
    save_bd!
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
