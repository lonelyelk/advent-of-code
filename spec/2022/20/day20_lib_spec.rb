# frozen_string_literal: true

require_relative "../../../2022/20/lib"

RSpec.describe Year2022::Day20 do
  include described_class

  let(:input) do
    %(1
2
-3
3
-2
0
4
)
  end
  let(:processed_input) do
    [1, 2, -3, 3, -2, 0, 4]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 3 for test input" do
      expect(problem1(processed_input)).to eq(3)
    end
  end

  describe "problem2" do
    it "returns 1623178306 for test input" do
      expect(problem2(processed_input)).to eq(1623178306)
    end
  end
end
