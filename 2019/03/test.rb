require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal(
  159,
  min_distance(
    %w[R75 D30 R83 U83 L12 D49 R71 U7 L72],
    %w[U62 R66 U55 R34 D71 R55 D58 R83],
  ),
  "Wrong distance",
)
assert_equal(
  135,
  min_distance(
    %w[R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51],
    %w[U98 R91 D20 R16 D67 R40 U7 R15 U6 R7],
  ),
  "Wrong distance",
)

assert_equal(
  610,
  min_steps(
    %w[R75 D30 R83 U83 L12 D49 R71 U7 L72],
    %w[U62 R66 U55 R34 D71 R55 D58 R83],
  ),
  "Wrong steps number",
)
assert_equal(
  410,
  min_steps(
    %w[R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51],
    %w[U98 R91 D20 R16 D67 R40 U7 R15 U6 R7],
  ),
  "Wrong steps number",
)
