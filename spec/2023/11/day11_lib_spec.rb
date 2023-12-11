# frozen_string_literal: true

require_relative "../../../2023/11/lib"

RSpec.describe Year2023::Day11 do
  include described_class

  let(:input) do
    %(...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....
)
  end
  let(:processed_input) do
    [
      [3, 0],
      [7, 1],
      [0, 2],
      [6, 4],
      [1, 5],
      [9, 6],
      [7, 8],
      [0, 9],
      [4, 9],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 374 for test input" do
      expect(problem1(processed_input)).to eq(374)
    end
  end

  describe "problem2" do
    it "returns 1030 for test input for factor 10" do
      expect(problem2(processed_input, 10)).to eq(1030)
    end

    it "returns 8410 for test input for factor 100" do
      expect(problem2(processed_input, 100)).to eq(8410)
    end
  end
end
