# frozen_string_literal: true

require_relative "../../../2024/18/lib"

RSpec.describe Year2024::Day18 do
  include described_class

  let(:input) do
    %(5,4
4,2
4,5
3,0
2,1
6,3
2,4
1,5
0,6
3,3
2,6
5,1
1,2
5,5
2,5
6,5
1,4
0,4
6,4
1,1
6,1
1,0
0,5
1,6
2,0
)
  end
  let(:processed_input) do
    [
      [5, 4],
      [4, 2],
      [4, 5],
      [3, 0],
      [2, 1],
      [6, 3],
      [2, 4],
      [1, 5],
      [0, 6],
      [3, 3],
      [2, 6],
      [5, 1],
      [1, 2],
      [5, 5],
      [2, 5],
      [6, 5],
      [1, 4],
      [0, 4],
      [6, 4],
      [1, 1],
      [6, 1],
      [1, 0],
      [0, 5],
      [1, 6],
      [2, 0],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 22 for test input" do
      expect(problem1(processed_input, [6, 6], 12)).to eq(22)
    end
  end

  describe "problem2" do
    it "returns '6,1' for test input" do
      expect(problem2(processed_input, [6, 6], 12)).to eq("6,1")
    end
  end
end
