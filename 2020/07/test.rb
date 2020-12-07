require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = "light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags."

parsed_rules = parse_rules(input.split("\n"))

assert_equal true, bag_found?(parsed_rules, parsed_rules["bright white"], "shiny gold"), "Bag must be there"
assert_equal true, bag_found?(parsed_rules, parsed_rules["dark orange"], "shiny gold"), "Bag must be there"
assert_equal true, bag_found?(parsed_rules, parsed_rules["light red"], "shiny gold"), "Bag must be there"
assert_equal false, bag_found?(parsed_rules, parsed_rules["faded blue"], "shiny gold"), "Bag is not there"
assert_equal false, bag_found?(parsed_rules, parsed_rules["dark olive"], "shiny gold"), "Bag is not there"

assert_equal 4, outer_bag_count(parsed_rules, "shiny gold"), "Wrong bag count"

assert_equal 32, inner_bag_count(parsed_rules, "shiny gold"), "Wrong bag count"

input = "shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags."

parsed_rules = parse_rules(input.split("\n"))

assert_equal 126, inner_bag_count(parsed_rules, "shiny gold"), "Wrong bag count"
