# frozen_string_literal: true

require_relative "../../../2024/09/lib"

RSpec.describe Year2024::Day09 do
  include described_class

  let(:input) do
    %(2333133121414131402
)
  end
  let(:processed_input) do
    "2333133121414131402"
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 1928 for test input" do
      expect(problem1(processed_input)).to eq(1928)
    end
  end

  describe "problem2" do
    it "returns 2858 for test input" do
      expect(problem2(processed_input)).to eq(2858)
    end
  end
end
