# frozen_string_literal: true

require_relative "../../../2023/13/lib"

RSpec.describe Year2023::Day13 do
  include described_class

  let(:input) do
    %(#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#
)
  end
  let(:processed_input) do
    [
      [
        "#.##..##.",
        "..#.##.#.",
        "##......#",
        "##......#",
        "..#.##.#.",
        "..##..##.",
        "#.#.##.#.",
      ],
      [
        "#...##..#",
        "#....#..#",
        "..##..###",
        "#####.##.",
        "#####.##.",
        "..##..###",
        "#....#..#",
      ],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 405 for test input" do
      expect(problem1(processed_input)).to eq(405)
    end
  end

  describe "problem2" do
    it "returns 400 for test input" do
      expect(problem2(processed_input)).to eq(400)
    end
  end
end
