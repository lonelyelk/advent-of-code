require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

assert_equal 514579, fix_report([1721, 979, 366, 299, 675, 1456]), "Wrong fix"
assert_equal 241861950, fix_report3([1721, 979, 366, 299, 675, 1456]), "Wrong fix"
