# frozen_string_literal: true

require_relative "../../../2021/09/lib"

RSpec.describe Day09 do
  include described_class

  let(:input) do
    %(
2199943210
3987894921
9856789892
8767896789
9899965678
)
  end
  let(:processed_input) do
    [
      [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
      [10, 2, 1, 9, 9, 9, 4, 3, 2, 1, 0, 10],
      [10, 3, 9, 8, 7, 8, 9, 4, 9, 2, 1, 10],
      [10, 9, 8, 5, 6, 7, 8, 9, 8, 9, 2, 10],
      [10, 8, 7, 6, 7, 8, 9, 6, 7, 8, 9, 10],
      [10, 9, 8, 9, 9, 9, 6, 5, 6, 7, 8, 10],
      [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 15 for test input" do
      expect(problem1(processed_input)).to eq(15)
    end
  end

  describe "problem2" do
    it "returns 1134 for test input" do
      expect(problem2(processed_input)).to eq(1134)
    end
  end
end
