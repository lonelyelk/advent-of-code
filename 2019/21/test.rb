require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

prog = File.read("input.txt").chomp.split(",").map(&:to_i)
script = <<SCRIPT
NOT D J
SCRIPT

walk(prog, script)
