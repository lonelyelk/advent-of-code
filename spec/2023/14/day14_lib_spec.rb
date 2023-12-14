# frozen_string_literal: true

require_relative "../../../2023/14/lib"

RSpec.describe Year2023::Day14 do
  include described_class

  let(:input) do
    %(O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
)
  end
  let(:processed_input) do
    [
      "O....#....",
      "O.OO#....#",
      ".....##...",
      "OO.#O....O",
      ".O.....O#.",
      "O.#..O.#.#",
      "..O..#O..O",
      ".......O..",
      "#....###..",
      "#OO..#....",
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 136 for test input" do
      expect(problem1(processed_input)).to eq(136)
    end
  end

  describe "problem2" do
    it "returns 64 for test input" do
      expect(problem2(processed_input)).to eq(64)
    end
  end
end
