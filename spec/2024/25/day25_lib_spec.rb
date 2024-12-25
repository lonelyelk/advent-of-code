# frozen_string_literal: true

require_relative "../../../2024/25/lib"

RSpec.describe Year2024::Day25 do
  include described_class

  let(:input) do
    %(#####
.####
.####
.####
.#.#.
.#...
.....

#####
##.##
.#.##
...##
...#.
...#.
.....

.....
#....
#....
#...#
#.#.#
#.###
#####

.....
.....
#.#..
###..
###.#
###.#
#####

.....
.....
.....
#....
#.#..
#.#.#
#####
)
  end
  let(:processed_input) do
    {
      locks: [
        [0, 5, 3, 4, 3],
        [1, 2, 0, 5, 3],
      ],
      keys: [
        [5, 0, 2, 1, 3],
        [4, 3, 4, 0, 2],
        [3, 0, 2, 0, 1],
      ],
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 3 for test input" do
      expect(problem1(processed_input)).to eq(3)
    end
  end
end
