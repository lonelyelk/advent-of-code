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
  puts tickets.inspect
  puts rules.inspect
  ticket = my_ticket.split(",").map(&:to_i)
  rules.keys.permutation.each do |rules_perm|
    puts rules_perm.inspect
    fit = tickets.all? do |t|
      re = rules_perm.each_with_index.all? do |rule, index|
        rules[rule].any? do |range|
          range.include?(t[index])
        end
      end
      re
    end
    if fit
      return rules_perm.each_with_index.each_with_object({}) do |(rule, index), obj|
        obj[rule] = ticket[index]
      end
    end
  end
end
