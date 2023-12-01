# frozen_string_literal: true

require_relative "../../../2023/01/lib"

RSpec.describe Year2023::Day01 do
  include described_class

  let(:input) do
    %(1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
)
  end
  let(:processed_input) do
    %w[
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    ]
  end
  let(:processed_input2) do
    %w[
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 142 for test input" do
      expect(problem1(processed_input)).to eq(142)
    end
  end

  describe "problem2" do
    it "returns 281 for test input" do
      expect(problem2(processed_input2)).to eq(281)
    end
  end
end
