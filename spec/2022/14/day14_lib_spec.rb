# frozen_string_literal: true

require_relative "../../../2022/14/lib"

RSpec.describe Year2022::Day14 do
  include described_class

  let(:input) do
    %(498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
)
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to match(instance_of(Hash))
    end
  end

  describe "problem1" do
    it "returns 24 for test input" do
      expect(problem1(process_input(input))).to eq(24)
    end
  end

  describe "problem2" do
    it "returns 93 for test input" do
      expect(problem2(process_input(input))).to eq(93)
    end
  end
end
