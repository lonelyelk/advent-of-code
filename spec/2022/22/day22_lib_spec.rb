# frozen_string_literal: true

require_relative "../../../2022/22/lib"

RSpec.describe Year2022::Day22 do
  include described_class

  let(:input) do
    %(        ...#
        .#..
        #...
        ....
...#.......#
........#...
..#....#....
..........#.
        ...#....
        .....#..
        .#......
        ......#.

10R5L5R10L4R5L5
)
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to match([an_instance_of(Hash), "10R5L5R10L4R5L5"])
    end
  end

  describe "problem1" do
    it "returns 6032 for test input" do
      expect(problem1(process_input(input))).to eq(6032)
    end
  end

  describe "problem2" do
    it "returns nil for test input" do
      expect(problem2(process_input(input))).to eq(nil)
    end
  end
end
