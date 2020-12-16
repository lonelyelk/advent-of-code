require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

rules = "class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50
".split("\n").map(&:chomp)

nearby_tickets = "7,3,47
40,4,50
55,2,20
38,6,12
".split("\n").map(&:chomp)

assert_equal 71, invalid_sum(rules, nearby_tickets), "Wrong sum"

rules = "class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19
".split("\n").map(&:chomp)
nearby_tickets = "3,9,18
15,1,5
5,14,9
".split("\n").map(&:chomp)
my_ticket = "11,12,13"

assert_equal ({class: 12, row: 11, seat: 13}), parse_ticket(rules, nearby_tickets, my_ticket), "Wrong parse"
