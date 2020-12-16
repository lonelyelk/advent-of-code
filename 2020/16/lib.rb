def invalid_sum(rules, tickets)
  ranges = rules.inject([]) do |arr, rule|
    rule.scan(/.+: (\d+)-(\d+) or (\d+)-(\d+)/).inject(arr) do |arr, (r1, r2, r3, r4)|
      arr + [(r1.to_i..r2.to_i), (r3.to_i..r4.to_i)]
    end
  end
  tickets.inject(0) do |invalid_sum, ticket|
    ticket.split(",").inject(invalid_sum) do |sum, num_s|
      if ranges.any? { |r| r.include?(num_s.to_i) }
        sum
      else
        sum + num_s.to_i
      end
    end
  end
end

def parse_ticket(rules_str, nearby_tickets, my_ticket)
  rules = rules_str.each_with_object({}) do |rule, obj|
    rule.scan(/(.+): (\d+)-(\d+) or (\d+)-(\d+)/).each_with_object(obj) do |(name, r1, r2, r3, r4), o|
      o[name.to_sym] = [(r1.to_i..r2.to_i), (r3.to_i..r4.to_i)]
    end
  end
  ranges = rules.values.flatten
  tickets = nearby_tickets.map { |str| str.split(",").map(&:to_i) }.select do |t|
    t.all? { |num| ranges.any? { |r| r.include?(num) } }
  end
  ticket = my_ticket.split(",").map(&:to_i)
  possible_matches = rules.each_with_object({}) do |(rule, ranges), match|
    match[rule] = (0...tickets.first.length).each_with_object([]) do |index, arr|
      if tickets.all? { |t| ranges.any? { |r| r.include?(t[index]) } }
        arr.push(index)
      end
    end
  end
  matches, solution = optimize(possible_matches)
  raise "Can't solve" unless matches.empty?

  solution.each_with_object({}) do |(rule, index), res|
    res[rule] = ticket[index]
  end
end

def optimize(possible_matches, prev_solution = {})
  one = possible_matches.select { |_k, v| v.length == 1 }
  if one.empty?
    return [possible_matches, prev_solution]
  end

  next_sol = one.each_with_object(prev_solution) do |(k, v), sol|
    sol[k] = v.first
  end
  next_matches = possible_matches.each_with_object({}) do |(k, v), mtch|
    mtch[k] = v - one.values.first unless one.key?(k)
  end
  optimize(next_matches, next_sol)
end
