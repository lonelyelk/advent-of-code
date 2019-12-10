def hidden_locations(x, y, x1, y1, x_min, y_min, x_max, y_max)
  dx = x1 - x
  dy = y1 - y
  gcd = dx.gcd(dy)
  dx = dx / gcd
  dy = dy / gcd
  res = []
  if dx == 0
    yh = y1 + dy / dy.abs
    xh = x1
    while yh.between?(y_min, y_max)
      res.push([xh, yh])
      yh = yh + dy / dy.abs
    end
  elsif dy == 0
    yh = y1
    xh = x1 + dx / dx.abs
    while xh.between?(x_min, x_max)
      res.push([xh, yh])
      xh = xh + dx / dx.abs
    end
  elsif dx % dy == 0
    yh = y1 + dy / dy.abs
    xh = x1 + dx / dy.abs
    while xh.between?(x_min, x_max) && yh.between?(y_min, y_max)
      res.push([xh, yh])
      yh = yh + dy / dy.abs
      xh = xh + dx / dy.abs
    end
  elsif dy % dx ==0
    yh = y1 + dy / dx.abs
    xh = x1 + dx / dx.abs
    while xh.between?(x_min, x_max) && yh.between?(y_min, y_max)
      res.push([xh, yh])
      yh = yh + dy / dx.abs
      xh = xh + dx / dx.abs
    end
  else
    yh = y1 + dy
    xh = x1 + dx
    while xh.between?(x_min, x_max) && yh.between?(y_min, y_max)
      res.push([xh, yh])
      yh = yh + dy
      xh = xh + dx
    end
  end
  res
end

def process_input(input)
  input.chomp.split(/[\n\r]+/).map(&:chars)
end

def output(arr)
  arr.map(&:join).join("\n")
end

def remove_hidden(arr, x, y, x1, y1)
  locations = hidden_locations(x, y, x1, y1, 0, 0, arr.first.length - 1, arr.length - 1)
  locations.each do |loc|
    arr[loc[1]][loc[0]] = "."
  end
  arr
end

def remove_all_hidden(arr, x, y)
  (0...arr.length).each do |y1|
    (0...arr[y1].length).each do |x1|
      next if arr[y1][x1] == "." || (x1 == x && y1 == y)
      remove_hidden(arr, x, y, x1, y1)
    end
  end
  arr
end

def rate_locations(arr)
  re = Array.new(arr.length) { |i| Array.new(arr[i].length) }
  (0...arr.length).each do |y|
    (0...arr[y].length).each do |x|
      if arr[y][x] == "."
        re[y][x] = 0
        next
      end
      clear_arr = remove_all_hidden(arr.map(&:dup), x, y)
      re[y][x] = clear_arr.map { |line| line.count { |c| c == "#" } }.inject(&:+) - 1
    end
  end
  re
end

def assign_angle_to_all(arr, x, y)
  re = []
  (0...arr.length).each do |y1|
    (0...arr[y1].length).each do |x1|
      next if arr[y1][x1] == "." || (x1 == x && y1 == y)
      angle = Math.atan2(x1 - x, y - y1)
      angle += 2.0 * Math::PI if angle < 0
      re.push([x1, y1, angle])
    end
  end
  re.sort_by { |point| point[2] }
end
