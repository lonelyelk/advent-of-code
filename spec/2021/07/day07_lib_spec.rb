# frozen_string_literal: true

require_relative "../../../2021/07/lib"

RSpec.describe Day07 do
  include described_class

  let(:input) do
    %(
16,1,2,0,4,2,7,1,2,14
)
  end
  let(:processed_input) do
    [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 37 for test input" do
      expect(problem1(processed_input)).to eq(37)
    end
  end

  describe "problem2" do
    it "returns 168 for test input" do
      expect(problem2(processed_input)).to eq(168)
    end
  end
end
