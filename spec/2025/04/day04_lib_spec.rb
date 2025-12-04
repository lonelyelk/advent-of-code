# frozen_string_literal: true

require_relative "../../../2025/04/lib"

RSpec.describe Year2025::Day04 do
  include described_class

  let(:input) do
    %(..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
)
  end

  describe "problem1" do
    it "returns 13 for test input" do
      expect(problem1(process_input(input))).to eq(13)
    end
  end

  describe "problem2" do
    it "returns 43 for test input" do
      expect(problem2(process_input(input))).to eq(43)
    end
  end
end
