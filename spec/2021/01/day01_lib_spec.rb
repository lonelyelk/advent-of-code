# frozen_string_literal: true

require_relative "../../../2021/01/lib"

RSpec.describe Day01 do
  include described_class

  let(:input) do
    %(
199
200
208
210
200
207
240
269
260
263
)
  end
  let(:processed_input) do
    [
      199,
      200,
      208,
      210,
      200,
      207,
      240,
      269,
      260,
      263,
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns an array of ints" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 7 for test input" do
      expect(problem1(processed_input)).to eq(7)
    end
  end

  describe "problem2" do
    it "returns 5 for test input" do
      expect(problem2(processed_input)).to eq(5)
    end
  end
end
