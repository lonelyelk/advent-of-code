# frozen_string_literal: true

require_relative "../../../2024/17/lib"

RSpec.describe Year2024::Day17 do
  include described_class

  let(:input) do
    %(Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0
)
  end
  let(:processed_input) do
    {
      a: 729,
      b: 0,
      c: 0,
      p: [0, 1, 5, 4, 3, 0],
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns '4,6,3,5,6,3,5,2,1,0' for test input" do
      expect(problem1(processed_input)).to eq("4,6,3,5,6,3,5,2,1,0")
    end
  end

  xdescribe "problem2" do
    let(:input_corrupt) do
      %(Register A: 2024
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0
)
    end

    it "returns 117440 for corrupt input" do
      expect(problem2(process_input(input_corrupt))).to eq(117_440)
    end
  end
end
