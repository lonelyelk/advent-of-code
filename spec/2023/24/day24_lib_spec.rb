# frozen_string_literal: true

require_relative "../../../2023/24/lib"

RSpec.describe Year2023::Day24 do
  include described_class

  let(:input) do
    %(19, 13, 30 @ -2,  1, -2
18, 19, 22 @ -1, -1, -2
20, 25, 34 @ -2, -2, -4
12, 31, 28 @ -1, -2, -1
20, 19, 15 @  1, -5, -3
)
  end
  let(:processed_input) do
    [
      [[19, 13, 30], [-2,  1, -2]],
      [[18, 19, 22], [-1, -1, -2]],
      [[20, 25, 34], [-2, -2, -4]],
      [[12, 31, 28], [-1, -2, -1]],
      [[20, 19, 15], [1, -5, -3]],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 2 for test input and range 7..27" do
      expect(problem1(processed_input, (7..27))).to eq(2)
    end
  end

  xdescribe "problem2" do
    it "returns nil for test input" do
      expect(problem2(processed_input)).to eq(nil)
    end
  end
end
