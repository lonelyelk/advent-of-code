require_relative "lib"

input = File.read("input.txt").chomp
rules, messages = input.split("\n\n")
re = Regexp.new("^#{rule_to_regexp_string(parse_rules(rules), "0")}$")
count = messages.split("\n").reject(&:empty?).count { |m| m.match?(re) }

puts count

input = File.read("input2.txt").chomp
rules, messages = input.split("\n\n")
re = Regexp.new("^#{rule_to_regexp_string(parse_rules(rules), "0")}$")
count = messages.split("\n").reject(&:empty?).count { |m| m.match?(re) }

puts count
