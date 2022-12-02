# frozen_string_literal: true

require_relative "../../../2021/21/lib"

RSpec.describe Day21 do
  include described_class

  let(:input) do
    %(Player 1 starting position: 4
Player 2 starting position: 8
)
  end
  let(:processed_input) do
    [3, 7]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 739_785 for test input" do
      expect(problem1(processed_input)).to eq(739_785)
    end
  end

  describe "problem2" do
    it "returns 444_356_092_776_315 for test input" do
      expect(problem2(processed_input)).to eq(444_356_092_776_315)
    end
  end
end
