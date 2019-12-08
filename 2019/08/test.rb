require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal(
  [0,1,1,0],
  Image.read(buffer: "0222112222120000", width: 2, height: 2).merged_layer,
  "Wrong merged layer",
)
