# frozen_string_literal: true

require_relative "../../../2022/08/lib"

RSpec.describe Year2022::Day08 do
  include described_class

  let(:input) do
    %(30373
25512
65332
33549
35390
)
  end
  let(:processed_input) do
    [
      [3, 0, 3, 7, 3],
      [2, 5, 5, 1, 2],
      [6, 5, 3, 3, 2],
      [3, 3, 5, 4, 9],
      [3, 5, 3, 9, 0],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 21 for test input" do
      expect(problem1(processed_input)).to eq(21)
    end
  end

  describe "problem2" do
    it "returns 8 for test input" do
      expect(problem2(processed_input)).to eq(8)
    end
  end
end
