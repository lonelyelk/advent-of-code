# frozen_string_literal: true

require_relative "../../../2025/09/lib"

RSpec.describe Year2025::Day09 do
  include described_class

  let(:input) do
    %(7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
)
  end
  let(:processed_input) do
    [
      [7, 1],
      [11, 1],
      [11, 7],
      [9, 7],
      [9, 5],
      [2, 5],
      [2, 3],
      [7, 3],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 50 for test input" do
      expect(problem1(processed_input)).to eq(50)
    end
  end

  describe "problem2" do
    it "returns 24 for test input" do
      expect(problem2(processed_input)).to eq(24)
    end
  end
end
