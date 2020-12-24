def locate_tile(line)
  line.scan(/[sn]?e|[sn]?w/).inject([0,0]) do |(x, y), dir|
    case dir
    when "se"
      [x+1, y-1]
    when "ne"
      [x+1, y+1]
    when "e"
      [x+2, y]
    when "sw"
      [x-1, y-1]
    when "nw"
      [x-1, y+1]
    when "w"
      [x-2, y]
    else
      raise dir
    end
  end
end

def flipped_tiles_count(input)
  flipped_tiles = input.chomp.split("\n").map do |line|
    locate_tile(line)
  end
  flipped_tiles.uniq.count do |tile|
    flipped_tiles.count(tile) % 2 == 1
  end
end

def b_tiles(input)
  flipped_tiles = input.chomp.split("\n").map do |line|
    locate_tile(line)
  end
  flipped_tiles.uniq.select do |tile|
    flipped_tiles.count(tile) % 2 == 1
  end.each_with_object({}) do |tile, acc|
    acc[tile_to_key(tile)] = true
  end
end

def tile_to_key(tile)
  tile.join(",")
end

def key_to_tile(key)
  key.split(",").map(&:to_i)
end

def neighbour_tiles(tile)
  [
    [tile[0]+1, tile[1]-1],
    [tile[0]+1, tile[1]+1],
    [tile[0]+2, tile[1]],
    [tile[0]-1, tile[1]-1],
    [tile[0]-1, tile[1]+1],
    [tile[0]-2, tile[1]],
  ]
end

def b_neighbour_tiles_count(key, b_tiles)
  neighbour_tiles(key_to_tile(key)).count { |tile| b_tiles[tile_to_key(tile)] }
end

def all_w_neighbours(b_tiles)
  b_tiles.each_with_object({}) do |(key, val), acc|
    next unless val
    neighbour_tiles(key_to_tile(key)).each do |tile|
      k = tile_to_key(tile)
      acc[k] = true unless b_tiles[k]
    end
  end
end

def game_of_tiles_round(b_tiles)
  new_w_tiles = b_tiles.each_with_object({}) do |(key, val), acc|
    next unless val
    neighbours = b_neighbour_tiles_count(key, b_tiles)
    acc[key] = true if neighbours == 0 || neighbours > 2
  end
  new_b_tiles = all_w_neighbours(b_tiles).each_with_object({}) do |(key, val), acc|
    next unless val
    acc[key] = true if b_neighbour_tiles_count(key, b_tiles) == 2
  end
  b_tiles = new_w_tiles.each_with_object(b_tiles) do |(key, val), acc|
    acc[key] = false if val
  end
  new_b_tiles.each_with_object(b_tiles) do |(key, val), acc|
    acc[key] = true if val
  end
end
