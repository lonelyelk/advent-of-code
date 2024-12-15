# frozen_string_literal: true

require_relative "../../../2024/15/lib"

RSpec.describe Year2024::Day15 do
  include described_class

  let(:input_small) do
    %(########
#..O.O.#
##@.O..#
#...O..#
#.#.O..#
#...O..#
#......#
########

<^^>>>vv<v>>v<<
)
  end

  describe "problem1" do
    it "returns 2028 for test input" do
      expect(problem1(process_input(input_small))).to eq(2028)
    end
  end

  xdescribe "problem2" do
    it "returns nil for test input" do
      expect(problem2(processed_input)).to eq(nil)
    end
  end
end
