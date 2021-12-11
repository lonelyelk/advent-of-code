# frozen_string_literal: true

require_relative "../../../2021/11/lib"

RSpec.describe Day11 do
  include described_class

  let(:input) do
    %(
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
)
  end
  let(:processed_input) do
    [
      [5, 4, 8, 3, 1, 4, 3, 2, 2, 3],
      [2, 7, 4, 5, 8, 5, 4, 7, 1, 1],
      [5, 2, 6, 4, 5, 5, 6, 1, 7, 3],
      [6, 1, 4, 1, 3, 3, 6, 1, 4, 6],
      [6, 3, 5, 7, 3, 8, 5, 4, 7, 8],
      [4, 1, 6, 7, 5, 2, 4, 6, 4, 5],
      [2, 1, 7, 6, 8, 4, 1, 7, 2, 1],
      [6, 8, 8, 2, 8, 8, 1, 1, 3, 4],
      [4, 8, 4, 6, 8, 4, 8, 5, 5, 4],
      [5, 2, 8, 3, 7, 5, 1, 5, 2, 6],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    let(:step2) do
      %(8807476555
        5089087054
        8597889608
        8485769600
        8700908800
        6600088989
        6800005943
        0000007456
        9000000876
        8700006848)
    end

    it "returns number of flashes on step 2 for test input" do
      flashes = step2.chars.count("0")
      expect(problem1(processed_input, 2)).to eq(flashes)
    end

    it "returns 204 for test input and step 10" do
      expect(problem1(processed_input, 10)).to eq(204)
    end

    it "returns 1656 for test input" do
      expect(problem1(processed_input)).to eq(1656)
    end
  end

  describe "problem2" do
    it "returns 195 for test input" do
      expect(problem2(processed_input)).to eq(195)
    end
  end
end
