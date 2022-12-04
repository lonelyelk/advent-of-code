# frozen_string_literal: true

require_relative "../../../2022/04/lib"

RSpec.describe Year2022::Day04 do
  include described_class

  let(:input) do
    %(
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
)
  end
  let(:processed_input) do
    [
      [(2..4), (6..8)],
      [(2..3), (4..5)],
      [(5..7), (7..9)],
      [(2..8), (3..7)],
      [(6..6), (4..6)],
      [(2..6), (4..8)],
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
