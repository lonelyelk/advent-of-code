# frozen_string_literal: true

require_relative "../../../2023/09/lib"

RSpec.describe Year2023::Day09 do
  include described_class

  let(:input) do
    %(0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
)
  end
  let(:processed_input) do
    [
      [0, 3, 6, 9, 12, 15],
      [1, 3, 6, 10, 15, 21],
      [10, 13, 16, 21, 30, 45],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 114 for test input" do
      expect(problem1(processed_input)).to eq(114)
    end
  end

  describe "problem2" do
    it "returns 2 for test input" do
      expect(problem2(processed_input)).to eq(2)
    end
  end
end
