require_relative "lib"
require "test/unit/assertions"
include Test::Unit::Assertions

input = "mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)
"

parsed = parse_input(input)
possible = possible_allergens(parsed)

assert_equal 5, no_allergens(parsed, possible).length, "Wrong count"

definite = 

assert_equal "mxmxvkd,sqjhc,fvjkl", definite_allergens(possible), "Wrong ingridients"
