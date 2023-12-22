# frozen_string_literal: true

require_relative "../../../2023/22/lib"

RSpec.describe Year2023::Day22 do
  include described_class

  let(:input) do
    %(1,0,1~1,2,1
0,0,2~2,0,2
0,2,3~2,2,3
0,0,4~0,2,4
2,0,5~2,2,5
0,1,6~2,1,6
1,1,8~1,1,9
)
  end
  let(:processed_input) do
    [
      [[1, 1], [0, 2], [1, 1]],
      [[0, 2], [0, 0], [2, 2]],
      [[0, 2], [2, 2], [3, 3]],
      [[0, 0], [0, 2], [4, 4]],
      [[2, 2], [0, 2], [5, 5]],
      [[0, 2], [1, 1], [6, 6]],
      [[1, 1], [1, 1], [8, 9]],
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
    it "returns 7 for test input" do
      expect(problem2(processed_input)).to eq(7)
    end
  end
end
