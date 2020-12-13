def next_bus(timestamp, buses_string)
  buses = buses_string
    .split(",")
    .select { |bus| bus.match?(/^\d+$/) }
    .map(&:to_i)
    .map { |b| [b, b - (timestamp % b)] }
  buses.min_by { |(b, d)| d }.inject(&:*)
end

def crt_timestamp_for(buses_string)
  buses = buses_string
    .split(",")
    .each_with_index.map do |b, i|
      if b.match?(/^\d+$/)
        bus = b.to_i
        [bus, (bus - i) % bus]
      else
        nil
      end
    end.compact.sort_by { |bus| bus.first }
  timestamp = buses.first.last
  diff = buses.first.first
  index = 1
  while index < buses.length
    if timestamp % buses[index].first == buses[index].last
      diff *= buses[index].first
      index += 1
    else
      while timestamp % buses[index].first != buses[index].last
        timestamp += diff
      end
    end
  end
  timestamp
end
