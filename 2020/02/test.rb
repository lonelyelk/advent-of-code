require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal 2, valid_passwords_count([
  "1-3 a: abcde",
  "1-3 b: cdefg",
  "2-9 c: ccccccccc",
]), "Wrong valid password count"

assert_equal 1, new_valid_passwords_count([
  "1-3 a: abcde",
  "1-3 b: cdefg",
  "2-9 c: ccccccccc",
]), "Wrong valid password count"
