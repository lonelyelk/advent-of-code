# frozen_string_literal: true

require_relative "../../../2025/05/lib"

RSpec.describe Year2025::Day05 do
  include described_class

  let(:input) do
    %(3-5
10-14
16-20
12-18

1
5
8
11
17
32
)
  end
  let(:processed_input) do
    {
      fresh: [
        (3..5),
        (10..14),
        (16..20),
        (12..18),
      ],
      inventory: [
        1,
        5,
        8,
        11,
        17,
        32,
      ],
    }
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
    it "returns 14 for test input" do
      expect(problem2(processed_input)).to eq(14)
    end
  end
end
