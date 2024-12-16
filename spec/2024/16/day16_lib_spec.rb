# frozen_string_literal: true

require_relative "../../../2024/16/lib"

RSpec.describe Year2024::Day16 do
  include described_class

  let(:input) do
    %(###############
#.......#....E#
#.#.###.#.###.#
#.....#.#...#.#
#.###.#####.#.#
#.#.#.......#.#
#.#.#####.###.#
#...........#.#
###.#.#####.#.#
#...#.....#.#.#
#.#.#.###.#.#.#
#.....#...#.#.#
#.###.#.#.#.#.#
#S..#.....#...#
###############
)
  end
  let(:processed_input) do
    {
      map: %w[
        ###############
        #.......#.....#
        #.#.###.#.###.#
        #.....#.#...#.#
        #.###.#####.#.#
        #.#.#.......#.#
        #.#.#####.###.#
        #...........#.#
        ###.#.#####.#.#
        #...#.....#.#.#
        #.#.#.###.#.#.#
        #.....#...#.#.#
        #.###.#.#.#.#.#
        #...#.....#...#
        ###############
      ],
      s: 1 + 13i,
      e: 13 + 1i,
    }
  end
  let(:input_bigger) do
    %(#################
#...#...#...#..E#
#.#.#.#.#.#.#.#.#
#.#.#.#...#...#.#
#.#.#.#.###.#.#.#
#...#.#.#.....#.#
#.#.#.#.#.#####.#
#.#...#.#.#.....#
#.#.#####.#.###.#
#.#.#.......#...#
#.#.###.#####.###
#.#.#...#.....#.#
#.#.#.#####.###.#
#.#.#.........#.#
#.#.#.#########.#
#S#.............#
#################
)
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 7036 for test input" do
      expect(problem1(processed_input)).to eq(7036)
    end

    it "returns 11048 for the bigger input" do
      expect(problem1(process_input(input_bigger))).to eq(11_048)
    end
  end

  describe "problem2" do
    it "returns 45 for test input" do
      expect(problem2(processed_input)).to eq(45)
    end

    it "returns 64 for the bigger input" do
      expect(problem2(process_input(input_bigger))).to eq(64)
    end
  end
end
