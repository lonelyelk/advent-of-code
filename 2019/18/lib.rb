class Pathfinder
  attr_reader :children, :key, :keys

  def initialize(map, path, point, keys)
    @map = map.map(&:dup)
    @path = path.dup
    @x = point[0]
    @y = point[1]
    @key = nil
    @keys = keys.dup
    @children = []
    @stopped = false
  end

  def stopped?
    @stopped
  end

  def stop
    @stopped = true
  end

  def move
    if x < 0 || y < 0 || y >= map.length || x >= map.first.length
      @stopped = true
      return
    end
    if @map[y][x] == "."
      @path.push([x, y])
      @map[y][x] = "@"
      @children = [[x+1, y], [x-1, y], [x, y+1], [x, y-1]].map { |point| Pathfinder.new(@map, @path, point)}
    elsif /[a-z]/.match?(@map[y][x])
      @path.push([x, y])
      @key = @map[y][x]
      @keys.push(@key)
    else
      @stopped = true
    end
  end
end

def solve(map)
  y = map.index { |line| line.include?("@") }
  x = map[y].index("@")
  pathfinders = [Pathfinder.new(map, [], [x, y], [])]
  while pathfinders.any? { |pf| !pf.stopped? } || pathfinders.empty?
    new_pathfinders = []
    pathfinders.each do |pf|
      pf.move
      next if pf.stopped
      if pf.key
        new_map = map.map do |line|
          line.map { |c| pf.}
        end
      end
    end
  end
end
