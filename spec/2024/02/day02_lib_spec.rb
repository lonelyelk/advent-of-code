# frozen_string_literal: true

require_relative "../../../2024/02/lib"

RSpec.describe Year2024::Day02 do
  include described_class

  let(:input) do
    %(7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
)
  end
  let(:processed_input) do
    [
      [7, 6, 4, 2, 1],
      [1, 2, 7, 8, 9],
      [9, 7, 6, 2, 1],
      [1, 3, 2, 4, 5],
      [8, 6, 4, 4, 1],
      [1, 3, 6, 7, 9],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 2 for test input" do
      expect(problem1(processed_input)).to eq(2)
    end
  end

  describe "problem2" do
    it "returns 4 for test input" do
      expect(problem2(processed_input)).to eq(4)
    end
  end
end
