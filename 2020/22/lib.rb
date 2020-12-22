def parse_input(input)
  input.split("\n").each_with_object([]) do |line, dealed|
    if line.match?(/Player/)
      dealed.push([])
    elsif line.match?(/\d+/)
      dealed.last.push(line.to_i)
    end
  end
end

def play(dealed)
  dealed = dealed.map(&:dup)
  while dealed.all? { |hand| !hand.empty? }
    round = dealed.map(&:shift)
    dealed[round.index(round.max)] += round.sort.reverse
  end
  dealed
end

def score(winner)
  winner.reverse.each_with_index.inject(0) do |s, (card, index)|
    s + card * (index + 1)
  end
end

def play_recursive(dealed, cache = {}, layer = 0)
  states = {}
  dealed = dealed.map(&:dup)
  cache_state_straight = dealed.map { |hand| hand.join(",") }.join("_")
  cache_state_reversed = dealed.reverse.map { |hand| hand.join(",") }.join("_")
  return cache[cache_state_straight] if cache[cache_state_straight]
  return cache[cache_state_reversed] if cache[cache_state_reversed]

  while dealed.all? { |hand| !hand.empty? }
    # puts states.keys.length
    # puts dealed.map(&:inspect).join("\n")
    # gets
    state = dealed.map { |hand| hand.join(",") }.join("_")
    if states[state]
      return [dealed[0], []]
    end

    states[state] = true
    round = dealed.map(&:shift)
    if round.each_with_index.all? { |card, index| card <= dealed[index].length }
      # puts "recursive! #{layer}"
      winner = play_recursive(dealed, cache, layer + 1).map(&:length)
      puts "returned! #{layer} cache size: #{cache.keys.length}"
      dealed[winner.index(winner.max)] += round.each_with_index.sort_by { |card, index| -winner[index] }.map(&:first)
    else
      dealed[round.index(round.max)] += round.sort.reverse
    end
  end
  cache[cache_state_straight] = dealed
  cache[cache_state_reversed] = dealed.reverse
  dealed
end
