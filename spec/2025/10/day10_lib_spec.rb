# frozen_string_literal: true

require_relative "../../../2025/10/lib"

RSpec.describe Year2025::Day10 do
  include described_class

  let(:input) do
    %([.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
)
  end

  describe "problem1" do
    it "returns 7 for test input" do
      expect(problem1(process_input(input))).to eq(7)
    end
  end

  describe "problem2" do
    it "returns 33 for test input" do
      expect(problem2(process_input(input))).to eq(33)
    end
  end
end
