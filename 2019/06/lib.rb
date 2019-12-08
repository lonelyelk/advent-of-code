def orbit_map(input)
  input.each_with_object({}) do |link, obj|
    center, moon = link.split(')')
    raise "ERROR" if obj[moon]
    obj[moon] = center
  end
end

def transfers_to_center(moon, map)
  arr = []
  m = map[moon]
  while m do
    arr.push(m)
    m = map[m]
  end
  arr
end

def total_orbits(map)
  map.keys.inject(0) do |acc, moon|
    acc + transfers_to_center(moon, map).length
  end
end

def possible_distances(map)
  transfers_to_center('YOU', map).map.with_index do |moon, i|
    index = transfers_to_center('SAN', map).index(moon)
    index.nil? ? nil : index + i
  end.compact.sort
end
