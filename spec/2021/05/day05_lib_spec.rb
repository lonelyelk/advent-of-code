# frozen_string_literal: true

require_relative "../../../2021/05/lib"

RSpec.describe Day05 do
  include described_class

  let(:input) do
    %(
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
)
  end
  let(:processed_input) do
    [
      [0, 9, 5, 9],
      [8, 0, 0, 8],
      [9, 4, 3, 4],
      [2, 2, 2, 1],
      [7, 0, 7, 4],
      [6, 4, 2, 0],
      [0, 9, 2, 9],
      [3, 4, 1, 4],
      [0, 0, 8, 8],
      [5, 5, 8, 2],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 5 for test input" do
      expect(problem1(processed_input)).to eq(5)
    end
  end

  describe "problem2" do
    it "returns 12 for test input" do
      expect(problem2(processed_input)).to eq(12)
    end
  end
end
