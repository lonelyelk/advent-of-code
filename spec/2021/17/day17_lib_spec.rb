# frozen_string_literal: true

require_relative "../../../2021/17/lib"

RSpec.describe Day17 do
  include described_class

  let(:input) do
    %(target area: x=20..30, y=-10..-5
)
  end
  let(:processed_input) do
    { x: [20, 30], y: [-10, -5] }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 45 for test input" do
      expect(problem1(processed_input)).to eq(45)
    end
  end

  describe "problem2" do
    it "returns 112 for test input" do
      expect(problem2(processed_input)).to eq(112)
    end
  end
end
