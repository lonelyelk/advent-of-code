# frozen_string_literal: true

require_relative "../../../2024/08/lib"

RSpec.describe Year2024::Day08 do
  include described_class

  let(:input) do
    %(............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
)
  end
  let(:processed_input) do
    %w[
      ............
      ........0...
      .....0......
      .......0....
      ....0.......
      ......A.....
      ............
      ............
      ........A...
      .........A..
      ............
      ............
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 14 for test input" do
      expect(problem1(processed_input)).to eq(14)
    end
  end

  describe "problem2" do
    it "returns 34 for test input" do
      expect(problem2(processed_input)).to eq(34)
    end
  end
end
