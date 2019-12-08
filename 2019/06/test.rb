require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = %w[
  COM)B
  B)C
  C)D
  D)E
  E)F
  B)G
  G)H
  D)I
  E)J
  J)K
  K)L
]
map = orbit_map(input)

assert_equal(
  42,
  total_orbits(map),
  "Wrong number of orbits",
)

input = %w[
  COM)B
  B)C
  C)D
  D)E
  E)F
  B)G
  G)H
  D)I
  E)J
  J)K
  K)L
  K)YOU
  I)SAN
]
map = orbit_map(input)


assert_equal(
  4,
  possible_distances(map).first,
  "Wrong number of transfers",
)
