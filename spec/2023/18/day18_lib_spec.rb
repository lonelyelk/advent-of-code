# frozen_string_literal: true

require_relative "../../../2023/18/lib"

RSpec.describe Year2023::Day18 do
  include described_class

  let(:input) do
    %(R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)
)
  end
  let(:processed_input) do
    [
      ["R", 6, "70c710"],
      ["D", 5, "0dc571"],
      ["L", 2, "5713f0"],
      ["D", 2, "d2c081"],
      ["R", 2, "59c680"],
      ["D", 2, "411b91"],
      ["L", 5, "8ceee2"],
      ["U", 2, "caa173"],
      ["L", 1, "1b58a2"],
      ["U", 2, "caa171"],
      ["R", 2, "7807d2"],
      ["U", 3, "a77fa3"],
      ["L", 2, "015232"],
      ["U", 2, "7a21e3"],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 62 for test input" do
      expect(problem1(processed_input)).to eq(62)
    end
  end

  describe "problem2" do
    it "returns 952408144115 for test input" do
      expect(problem2(processed_input)).to eq(952408144115)
    end
  end
end
