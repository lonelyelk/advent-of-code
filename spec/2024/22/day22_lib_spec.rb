# frozen_string_literal: true

require_relative "../../../2024/22/lib"

RSpec.describe Year2024::Day22 do
  include described_class

  let(:input) do
    %(1
10
100
2024
)
  end
  let(:processed_input) do
    [
      1,
      10,
      100,
      2024,
    ]
  end
  let(:another_processed_input) do
    [
      1,
      2,
      3,
      2024,
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 37327623 for test input" do
      expect(problem1(processed_input)).to eq(37_327_623)
    end
  end

  describe "problem2" do
    it "returns 23 for test input" do
      expect(problem2(another_processed_input)).to eq(23)
    end
  end
end
