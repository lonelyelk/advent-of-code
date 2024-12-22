# frozen_string_literal: true

require_relative "../../../2024/20/lib"

RSpec.describe Year2024::Day20 do
  include described_class

  let(:input) do
    %(###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
)
  end
  let(:processed_input) do
    {
      map: %w[
        ###############
        #...#...#.....#
        #.#.#.#.#.###.#
        #.#...#.#.#...#
        #######.#.#.###
        #######.#.#...#
        #######.#.###.#
        ###...#...#...#
        ###.#######.###
        #...###...#...#
        #.#####.#.###.#
        #.#...#.#.#...#
        #.#.#.#.#.#.###
        #...#...#...###
        ###############
      ],
      s: [1, 3],
      e: [5, 7],
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 10 for test input" do
      expect(problem1(processed_input, 10)).to eq(10)
    end
  end

  describe "problem2" do
    it "returns 285 for test input" do
      expect(problem2(processed_input, 50)).to eq(285)
    end
  end
end
