# frozen_string_literal: true

require_relative "../../../2024/14/lib"

RSpec.describe Year2024::Day14 do
  include described_class

  let(:input) do
    %(p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3
)
  end
  let(:processed_input) do
    [
      [[0, 4], [3, -3]],
      [[6, 3], [-1, -3]],
      [[10, 3], [-1, 2]],
      [[2, 0], [2, -1]],
      [[0, 0], [1, 3]],
      [[3, 0], [-2, -2]],
      [[7, 6], [-1, -3]],
      [[3, 0], [-1, -2]],
      [[9, 3], [2, 3]],
      [[7, 3], [-1, 2]],
      [[2, 4], [2, -3]],
      [[9, 5], [-3, -3]],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 12 for test input" do
      expect(problem1(processed_input, [11, 7])).to eq(12)
    end
  end
end
