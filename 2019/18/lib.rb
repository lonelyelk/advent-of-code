class Pathfinder
  attr_reader :children, :key, :keys, :path

  def initialize(map:, path:, point:, keys:)
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

  def point
    [@x, @y]
  end

  def move
    if @x < 0 || @y < 0 || @y >= @map.length || @x >= @map.first.length
      @stopped = true
      return
    end
    if @map[@y][@x] == "."
      @path.push([@x, @y])
      @map[@y][@x] = "@"
      @children = [[@x+1, @y], [@x-1, @y], [@x, @y+1], [@x, @y-1]].map do |pt|
        Pathfinder.new(map: @map, path: @path, point: pt, keys: @keys)
      end
    elsif /[a-z]/.match?(@map[@y][@x])
      @key = @map[@y][@x]
      @keys.push(@key)
    else
      @stopped = true
    end
  end

  def plot
    @map.each do |line|
      puts line.join
    end
    puts
  end
end

def solve(map)
  y = map.index { |line| line.include?("@") }
  x = map[y].index("@")
  map[y][x] = "."
  pathfinders = [Pathfinder.new(map: map, path: [], point: [x, y], keys: [])]
  successful_pathfinders = []
  while pathfinders.any? { |pf| !pf.stopped? } || pathfinders.empty? do
    new_pathfinders = []
    pathfinders.each do |pf|
      pf.move
      next if pf.stopped?
      # pf.plot
      # sleep 0.1
      if pf.key
        puts pf.keys.inspect
        new_map = map.map do |line|
          line.map do |c|
            if pf.keys.include?(c.downcase)
              "."
            elsif c == "@"
              "."
            else
              c
            end
          end
        end
        if new_map.any? { |line| line.any? { |c| /[a-z]/i.match?(c) } }
          new_pathfinders.push(Pathfinder.new(map: new_map, path: pf.path, point: pf.point, keys: pf.keys))
        else
          successful_pathfinders.push(pf)
        end
      else
        new_pathfinders += pf.children
      end
    end
    pathfinders = new_pathfinders
    puts pathfinders.length
  end
  successful_pathfinders
end
