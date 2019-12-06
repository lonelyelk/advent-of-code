input = File.readlines("input6.txt").map(&:chomp)
# input = %w[COM)B
#     B)C
#     C)D
#     D)E
#     E)F
#     B)G
#     G)H
#     D)I
#     E)J
#     J)K
#     K)L
#     K)YOU
#     I)SAN]

map = input.each_with_object({}) do |link, obj|
    center, moon = link.split(')')
    raise "ERROR" if obj[moon]
    obj[moon] = center
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

total_orbits = map.keys.inject(0) do |acc, moon|
    acc + transfers_to_center(moon, map).length
end

puts total_orbits
# puts transfers_to_center('YOU', map).inspect
# puts transfers_to_center('SAN', map).inspect

distances = transfers_to_center('YOU', map).map.with_index do |moon, i|
    index = transfers_to_center('SAN', map).index(moon)
    puts "#{index} | #{i}"
    index.nil? ? nil : index + i
end.compact.sort.inspect

puts distances