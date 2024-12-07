# frozen_string_literal: true

require_relative "../../../2024/07/lib"

RSpec.describe Year2024::Day07 do
  include described_class

  let(:input) do
    %(190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
)
  end
  let(:processed_input) do
    [
      [190, [10, 19]],
      [3267, [81, 40, 27]],
      [83, [17, 5]],
      [156, [15, 6]],
      [7290, [6, 8, 6, 15]],
      [161_011, [16, 10, 13]],
      [192, [17, 8, 14]],
      [21_037, [9, 7, 18, 13]],
      [292, [11, 6, 16, 20]],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 3749 for test input" do
      expect(problem1(processed_input)).to eq(3749)
    end
  end

  describe "problem2" do
    it "returns 11_387 for test input" do
      expect(problem2(processed_input)).to eq(11_387)
    end
  end
end
