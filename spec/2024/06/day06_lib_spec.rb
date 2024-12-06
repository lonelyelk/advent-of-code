# frozen_string_literal: true

require_relative "../../../2024/06/lib"

RSpec.describe Year2024::Day06 do
  include described_class

  let(:input) do
    %(....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
)
  end
  let(:processed_input) do
    {
      map: %w[
        ....#.....
        .........#
        ..........
        ..#.......
        .......#..
        ..........
        .#........
        ........#.
        #.........
        ......#...
      ],
      pos: Complex(4, 6),
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 41 for test input" do
      expect(problem1(processed_input)).to eq(41)
    end
  end

  describe "problem2" do
    it "returns 6 for test input" do
      expect(problem2(processed_input)).to eq(6)
    end
  end
end
