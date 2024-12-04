# frozen_string_literal: true

require_relative "../../../2024/04/lib"

RSpec.describe Year2024::Day04 do
  include described_class

  let(:input) do
    %(MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
)
  end
  let(:processed_input) do
    %w[
      MMMSXXMASM
      MSAMXMSMSA
      AMXSXMAAMM
      MSAMASMSMX
      XMASAMXAMM
      XXAMMXXAMA
      SMSMSASXSS
      SAXAMASAAA
      MAMMMXMMMM
      MXMXAXMASX
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 18 for test input" do
      expect(problem1(processed_input)).to eq(18)
    end
  end

  describe "problem2" do
    it "returns 9 for test input" do
      expect(problem2(processed_input)).to eq(9)
    end
  end
end
