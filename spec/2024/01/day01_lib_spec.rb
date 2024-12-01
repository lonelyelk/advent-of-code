# frozen_string_literal: true

require_relative "../../../2024/01/lib"

RSpec.describe Year2024::Day01 do
  include described_class

  let(:input) do
    %(3   4
4   3
2   5
1   3
3   9
3   3
)
  end
  let(:processed_input) do
    [[3, 4, 2, 1, 3, 3], [4, 3, 5, 3, 9, 3]]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns nil for test input" do
      expect(problem1(processed_input)).to eq(11)
    end
  end

  describe "problem2" do
    it "returns nil for test input" do
      expect(problem2(processed_input)).to eq(31)
    end
  end
end
