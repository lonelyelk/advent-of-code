# frozen_string_literal: true

require_relative "../../../2022/17/lib"

RSpec.describe Year2022::Day17 do
  include described_class

  let(:input) do
    %(>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>
)
  end
  let(:processed_input) do
    ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 3068 for test input" do
      expect(problem1(processed_input)).to eq(3068)
    end
  end

  describe "problem2" do
    it "returns 1_514_285_714_288 for test input" do
      expect(problem2(processed_input)).to eq(1_514_285_714_288)
    end
  end
end
