require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = "sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew
"

assert_equal 10, flipped_tiles_count(input), "Wrong count"

b_t = b_tiles(input)
assert_equal 10, b_t.length, "Wrong count"
b_t = game_of_tiles_round(b_t)
assert_equal 15, b_t.select { |_, v| v }.length, "Wrong count"
b_t = game_of_tiles_round(b_t)
assert_equal 12, b_t.select { |_, v| v }.length, "Wrong count"
b_t = game_of_tiles_round(b_t)
assert_equal 25, b_t.select { |_, v| v }.length, "Wrong count"
b_t = game_of_tiles_round(b_t)
assert_equal 14, b_t.select { |_, v| v }.length, "Wrong count"

b_t = b_tiles(input)
100.times do |i|
  b_t = game_of_tiles_round(b_t)
end
assert_equal 2208, b_t.select { |_, v| v }.length, "Wrong count"
