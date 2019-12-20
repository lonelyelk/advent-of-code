def map_portals(map)
  map.each_with_object({}).with_index do |(line, obj), y|
    line.each_with_index do |c, x|
      next unless c == "."

      gate = [
        map[y-2][x] + map[y-1][x],
        map[y+1][x] + map[y+2][x],
        map[y][x-2] + map[y][x-1],
        map[y][x+1] + map[y][x+2],
      ].detect { |gate| gate.match?(/[A-Z]{2}/) }
      next unless gate

      obj[gate] ||= []
      obj[gate].push([x, y])
    end
  end
end

def path(map)
  portal_map = map_portals(map)
  pathfinder = portal_map.delete("AA").first
  steps = 0
  map_path = map.map(&:dup)
  map_path[pathfinder[1]][pathfinder[0]] = "o"
  swarm = [pathfinder]
  while !swarm.empty?
    new_swarm = []
    swarm.each do |pt|
      pt_portal = portal_map.select { |name, points| points.include?(pt) }
      unless pt_portal.empty?
        return steps if pt_portal["ZZ"]
        portal_pts = portal_map.delete(pt_portal.keys.first)
        new_swarm.push(portal_pts.detect { |portal_pt| portal_pt != pt })
      end
      [
        [pt[0]-1, pt[1]],
        [pt[0]+1, pt[1]],
        [pt[0], pt[1]-1],
        [pt[0], pt[1]+1],
      ].each do |near_pt|
        new_swarm.push(near_pt) if map_path[near_pt[1]][near_pt[0]] == "."
      end
    end
    new_swarm.each do |pt|
      map_path[pt[1]][pt[0]] = "o"
    end
    swarm = new_swarm
    steps += 1
  end
  steps
end

def path_recursive(map)
  portal_map = map_portals(map)
  pathfinder = portal_map["AA"].first + [0, "o", "+"]
  exiter = portal_map["ZZ"].first + [0, "+", "o"]
  steps = 0
  map_path = [map.map(&:dup)]
  map_path[pathfinder[2]][pathfinder[1]][pathfinder[0]] = pathfinder[3]
  map_path[exiter[2]][exiter[1]][exiter[0]] = exiter[3]
  swarm = [pathfinder, exiter]
  while !swarm.empty?
    new_swarm = []
    swarm.each do |pt|
      pt_portal = portal_map.select { |name, points| points.include?(pt[0..1]) }
      unless pt_portal.empty?
        other_side_pt = pt_portal.values.first.detect { |portal_pt| portal_pt != pt[0..1] }
        if pt[0] == 2 || pt[0] == map.first.length - 3 || pt[1] == 2 || pt[1] == map.length - 3
          if pt[2] > 0 && other_side_pt
            new_swarm.push(other_side_pt + [pt[2] - 1, pt[3], pt[4]])
          end
        elsif other_side_pt
          new_swarm.push(other_side_pt + [pt[2] + 1, pt[3], pt[4]])
        end
      end
      [
        [pt[0]-1, pt[1], pt[2], pt[3], pt[4]],
        [pt[0]+1, pt[1], pt[2], pt[3], pt[4]],
        [pt[0], pt[1]-1, pt[2], pt[3], pt[4]],
        [pt[0], pt[1]+1, pt[2], pt[3], pt[4]],
      ].each do |near_pt|
        return steps*2 if map_path[near_pt[2]][near_pt[1]][near_pt[0]] == near_pt[4]
        new_swarm.push(near_pt) if map_path[near_pt[2]][near_pt[1]][near_pt[0]] == "."
      end
    end
    new_swarm.each do |pt|
      map_path[pt[2]] ||= map.map(&:dup)
      map_path[pt[2]][pt[1]][pt[0]] = pt[3]
    end
    swarm = new_swarm
    steps += 1
    # puts "SWARM: #{swarm.length}; LEVELS: #{map_path.length}"
  end
  steps
end
