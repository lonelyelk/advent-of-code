# frozen_string_literal: true

require_relative "../../../2024/11/lib"

RSpec.describe Year2024::Day11 do
  include described_class

  let(:input) do
    %(125 17
)
  end
  let(:processed_input) do
    {
      "125" => 1,
      "17" => 1,
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 22 for test input and 6 blinks" do
      expect(problem1(processed_input, 6)).to eq(22)
    end

    it "returns 55312 for test input and 25 (default) blinks" do
      expect(problem1(processed_input)).to eq(55_312)
    end
  end
end
