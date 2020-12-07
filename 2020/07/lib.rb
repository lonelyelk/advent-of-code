def parse_rules(rules)
  rules.each_with_object({}) do |rule, set|
    md = rule.match(/^(\w+ \w+) bags/)
    set[md[1]] =
      rule.scan(/(\d+) (\w+ \w+) bags?[.,]/).each_with_object({}) { |(num, b), s| s[b] = num.to_i }
  end
end

def bag_found?(parsed_rules, rule, bag, starting_bag = nil)
  return false if rule.keys.empty?

  return true if rule.key?(bag)

  rule.keys.any? do |b|
    b != starting_bag && bag_found?(parsed_rules, parsed_rules[b], bag, starting_bag)
  end
end

def outer_bag_count(parsed_rules, bag)
  parsed_rules.keys.select do |b|
    b != bag && bag_found?(parsed_rules, parsed_rules[b], bag, b)
  end.length
end

def inner_bag_count(parsed_rules, bag)
  return 0 if parsed_rules[bag].empty?

  parsed_rules[bag].inject(0) do |sum, (b, num)|
    sum + num + num * inner_bag_count(parsed_rules, b)
  end
end
