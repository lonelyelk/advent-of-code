# frozen_string_literal: true

require_relative "../../../2023/03/lib"

RSpec.describe Year2023::Day03 do
  include described_class

  let(:input) do
    %(467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
)
  end
  let(:processed_input) do
    [
      "467..114..",
      "...*......",
      "..35..633.",
      "......#...",
      "617*......",
      ".....+.58.",
      "..592.....",
      "......755.",
      "...$.*....",
      ".664.598..",
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 4361 for test input" do
      expect(problem1(processed_input)).to eq(4361)
    end
  end

  describe "problem2" do
    it "returns 467835 for test input" do
      expect(problem2(processed_input)).to eq(467835)
    end
  end
end
