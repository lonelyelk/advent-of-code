# frozen_string_literal: true

require_relative "../../../2023/21/lib"

RSpec.describe Year2023::Day21 do
  include described_class

  let(:input) do
    %(...........
.....###.#.
.###.##..#.
..#.#...#..
....#.#....
.##..S####.
.##..#...#.
.......##..
.##.#.####.
.##..##.##.
...........
)
  end

  describe "problem1" do
    it "returns 16 for test input" do
      expect(problem1(process_input(input), 6)).to eq(16)
    end
  end

  describe "problem2", skip: "too slow to run every time" do
    {
      6 => 16,
      10 => 50,
      50 => 1594,
      100 => 6536,
      # 500 => 167004,
      # 1000 => 668697,
      # 5000 => 16733044,
    }.each do |steps, spots|
      it "returns #{spots} for test input in #{steps} steps" do
        p steps
        expect(problem2(process_input(input), steps)).to eq(spots)
      end
    end
  end
end
