# frozen_string_literal: true

require_relative "../../../2021/13/lib"

RSpec.describe Day13 do
  include described_class

  let(:input) do
    %(
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
)
  end
  let(:processed_input) do
    [
      [
        [6, 10],
        [0, 14],
        [9, 10],
        [0, 3],
        [10, 4],
        [4, 11],
        [6, 0],
        [6, 12],
        [4, 1],
        [0, 13],
        [10, 12],
        [3, 4],
        [3, 0],
        [8, 4],
        [1, 10],
        [2, 14],
        [8, 10],
        [9, 0],
      ],
      [
        [0, 7],
        [5, 0],
      ],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 17 for test input" do
      expect(problem1(processed_input)).to eq(17)
    end
  end

  describe "problem2" do
    it "returns ascii O for test input" do
      expected = %(#####
#...#
#...#
#...#
#####)
      expect(problem2(processed_input)).to eq(expected)
    end
  end
end
