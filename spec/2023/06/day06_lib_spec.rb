# frozen_string_literal: true

require_relative "../../../2023/06/lib"

RSpec.describe Year2023::Day06 do
  include described_class

  let(:input) do
    %(Time:      7  15   30
Distance:  9  40  200
)
  end
  let(:processed_input) do
    [[7, 9], [15, 40], [30, 200]]
  end
  let(:processed_input2) do
    [71_530, 940_200]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end

    it "consumes multiline string and returns processed input for the problem 2" do
      expect(process_input2(input)).to eq(processed_input2)
    end
  end

  describe "problem1" do
    it "returns 288 for test input" do
      expect(problem1(processed_input)).to eq(288)
    end
  end

  describe "problem2" do
    it "returns 71503 for test input" do
      expect(problem2(processed_input2)).to eq(71_503)
    end
  end
end
