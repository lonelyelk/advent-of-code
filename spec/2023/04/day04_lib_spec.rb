# frozen_string_literal: true

require_relative "../../../2023/04/lib"

RSpec.describe Year2023::Day04 do
  include described_class

  let(:input) do
    %(Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
)
  end
  let(:processed_input) do
    [
      [[41, 48, 83, 86, 17], [83, 86,  6, 31, 17,  9, 48, 53]],
      [[13, 32, 20, 16, 61], [61, 30, 68, 82, 17, 32, 24, 19]],
      [[ 1, 21, 53, 59, 44], [69, 82, 63, 72, 16, 21, 14,  1]],
      [[41, 92, 73, 84, 69], [59, 84, 76, 51, 58,  5, 54, 83]],
      [[87, 83, 26, 28, 32], [88, 30, 70, 12, 93, 22, 82, 36]],
      [[31, 18, 13, 56, 72], [74, 77, 10, 23, 35, 67, 36, 11]],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 13 for test input" do
      expect(problem1(processed_input)).to eq(13)
    end
  end

  describe "problem2" do
    it "returns 30 for test input" do
      expect(problem2(processed_input)).to eq(30)
    end
  end
end
