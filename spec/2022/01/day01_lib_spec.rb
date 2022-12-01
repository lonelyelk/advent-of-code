# frozen_string_literal: true

require_relative "../../../2022/01/lib"

RSpec.describe Year2022::Day01 do
  include described_class

  let(:input) do
    %(
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
)
  end
  let(:processed_input) do
    [
      [
        1000,
        2000,
        3000,
      ],
      [
        4000,
      ],
      [
        5000,
        6000,
      ],
      [
        7000,
        8000,
        9000,
      ],
      [
        10_000,
      ],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns an array of ints" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 24000 for test input" do
      expect(problem1(processed_input)).to eq(24_000)
    end
  end

  describe "problem2" do
    it "returns 45000 for test input" do
      expect(problem2(processed_input)).to eq(45_000)
    end
  end
end
