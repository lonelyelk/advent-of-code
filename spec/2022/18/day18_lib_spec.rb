# frozen_string_literal: true

require_relative "../../../2022/18/lib"

RSpec.describe Year2022::Day18 do
  include described_class

  let(:input) do
    %(2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5
)
  end
  let(:processed_input) do
    [
      [2, 2, 2],
      [1, 2, 2],
      [3, 2, 2],
      [2, 1, 2],
      [2, 3, 2],
      [2, 2, 1],
      [2, 2, 3],
      [2, 2, 4],
      [2, 2, 6],
      [1, 2, 5],
      [3, 2, 5],
      [2, 1, 5],
      [2, 3, 5],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 64 for test input" do
      expect(problem1(processed_input)).to eq(64)
    end
  end

  describe "problem2" do
    it "returns 58 for test input" do
      expect(problem2(processed_input)).to eq(58)
    end
  end
end
