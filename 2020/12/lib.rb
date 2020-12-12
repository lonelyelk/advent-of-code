def manhattan_distance_to(instructions)
  direction = "E"
  x = y = 0
  instructions.each do |instruction|
    md = instruction.match(/^(\w)(\d+)$/)
    case md[1]
    when "N", "S", "E", "W"
      x, y = move_with_direction(x, y, md[1], md[2].to_i)
    when "L"
      direction = rotate_right(direction, -(md[2].to_i))
    when "R"
      direction = rotate_right(direction, md[2].to_i)
    when "F"
      x, y = move_with_direction(x, y, direction, md[2].to_i)
    end
  end
  x.abs + y.abs
end

def move_with_direction(x, y, dir, diff)
  case dir
  when "N"
    [x, y + diff]
  when "S"
    [x, y - diff]
  when "E"
    [x + diff, y]
  when "W"
    [x - diff, y]
  end
end

def rotate_right(dir, angle)
  right_rotation = %w[E S W N]
  index = right_rotation.index(dir)
  diff = (angle / 90) % right_rotation.length
  new_index = index + diff
  while new_index >= right_rotation.length
    new_index -= right_rotation.length
  end
  while new_index < 0
    new_index += right_rotation.length
  end
  right_rotation[new_index]
end

def rotate_waypoint_right(wx, wy, angle)
  diff = (angle / 90) % 4
  diff.times do
    wx, wy = rotate_waypoint_right_once(wx, wy)
  end
  [wx, wy]
end

def rotate_waypoint_right_once(wx, wy)
  [wy, -wx]
end

def navigate(instructions)
  wx = 10
  wy = 1
  x = y = 0

  instructions.each do |instruction|
    md = instruction.match(/^(\w)(\d+)$/)
    case md[1]
    when "N", "S", "E", "W"
      wx, wy = move_with_direction(wx, wy, md[1], md[2].to_i)
    when "L"
      wx, wy = rotate_waypoint_right(wx, wy, -(md[2].to_i))
    when "R"
      wx, wy = rotate_waypoint_right(wx, wy, md[2].to_i)
    when "F"
      x += wx * (md[2].to_i)
      y += wy * (md[2].to_i)
    end
  end
  x.abs + y.abs
end
