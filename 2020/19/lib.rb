def parse_rules(input)
  input.split("\n").map(&:chomp).reject(&:empty?).each_with_object({}) do |line, rules|
    md = line.match(/^(\d+): (.+)$/)
    rules[md[1]] = md[2]
  end
end

def rule_to_regexp_string(rules, rule)
  if (md = rule.match(/"(\w)"/))
    md[1]
  elsif rule.match?(/^42 \| 42 8$/) # patch
    "(#{rule_to_regexp_string(rules, rules["42"])})+"
  elsif rule.match?(/^42 31 \| 42 11 31$/) # patch
    r42 = rule_to_regexp_string(rules, rules["42"])
    r31 = rule_to_regexp_string(rules, rules["31"])
    arr = (1..10).map do |num| # should be enough :)
      r42 * num + r31 * num
    end
    "(#{arr.join("|")})"
  elsif rule.match?(/^[0-9 ]+$/)
    rule.split.map { |r| rule_to_regexp_string(rules, rules[r]) }.join
  elsif rule.include?("|")
    "(#{rule.split(/ +\| +/).map { |r| rule_to_regexp_string(rules, r) }.join("|")})"
  else
    raise rule
  end
end
