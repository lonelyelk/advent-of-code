# frozen_string_literal: true

require_relative "../../../2024/19/lib"

RSpec.describe Year2024::Day19 do
  include described_class

  let(:input) do
    %(r, wr, b, g, bwu, rb, gb, br

brwrr
bggr
gbbr
rrbgbr
ubwu
bwurrg
brgr
bbrgwb
)
  end
  let(:processed_input) do
    [
      %w[r wr b g bwu rb gb br],
      %w[
        brwrr
        bggr
        gbbr
        rrbgbr
        ubwu
        bwurrg
        brgr
        bbrgwb
      ],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 6 for test input" do
      expect(problem1(processed_input)).to eq(6)
    end
  end

  describe "problem2" do
    it "returns nil for test input" do
      expect(problem2(processed_input)).to eq(nil)
    end
  end
end
