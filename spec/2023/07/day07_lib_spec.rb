# frozen_string_literal: true

require_relative "../../../2023/07/lib"

RSpec.describe Year2023::Day07 do
  include described_class

  let(:input) do
    %(32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
)
  end
  let(:processed_input) do
    [
      ["32T3K", 765],
      ["T55J5", 684],
      ["KK677", 28],
      ["KTJJT", 220],
      ["QQQJA", 483],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 6440 for test input" do
      expect(problem1(processed_input)).to eq(6440)
    end
  end

  describe "problem2" do
    it "returns 5905 for test input" do
      expect(problem2(processed_input)).to eq(5905)
    end
  end
end
