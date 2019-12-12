require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

scan = <<SCAN
<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>
SCAN

sys = MoonSystem.new(scan.chomp.split("\n"))
sys.step!

assert_equal([2,-1,1], sys.moons[0].pos, "Wrong Io pos")
assert_equal([3,-1,-1], sys.moons[0].vel, "Wrong Io vel")

sys.steps!(9)

assert_equal([2,0,4], sys.moons[3].pos, "Wrong Callisto pos")
assert_equal([1,-1,-1], sys.moons[3].vel, "Wrong Callisto vel")

assert_equal(179, sys.tot, "Wrong total sys energy")

scan = <<SCAN
<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>
SCAN
sys = MoonSystem.new(scan.chomp.split("\n"))

assert_equal(4686774924, return_to_start_steps(sys), "Wrong period number")
