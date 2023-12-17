# frozen_string_literal: true

require_relative "../../../2023/17/lib"

RSpec.describe Year2023::Day17 do
  include described_class

  let(:input) do
    %(2413432311323
3215453535623
3255245654254
3446585845452
4546657867536
1438598798454
4457876987766
3637877979653
4654967986887
4564679986453
1224686865563
2546548887735
4322674655533
)
  end
  let(:processed_input) do
    [
      [2, 4, 1, 3, 4, 3, 2, 3, 1, 1, 3, 2, 3],
      [3, 2, 1, 5, 4, 5, 3, 5, 3, 5, 6, 2, 3],
      [3, 2, 5, 5, 2, 4, 5, 6, 5, 4, 2, 5, 4],
      [3, 4, 4, 6, 5, 8, 5, 8, 4, 5, 4, 5, 2],
      [4, 5, 4, 6, 6, 5, 7, 8, 6, 7, 5, 3, 6],
      [1, 4, 3, 8, 5, 9, 8, 7, 9, 8, 4, 5, 4],
      [4, 4, 5, 7, 8, 7, 6, 9, 8, 7, 7, 6, 6],
      [3, 6, 3, 7, 8, 7, 7, 9, 7, 9, 6, 5, 3],
      [4, 6, 5, 4, 9, 6, 7, 9, 8, 6, 8, 8, 7],
      [4, 5, 6, 4, 6, 7, 9, 9, 8, 6, 4, 5, 3],
      [1, 2, 2, 4, 6, 8, 6, 8, 6, 5, 5, 6, 3],
      [2, 5, 4, 6, 5, 4, 8, 8, 8, 7, 7, 3, 5],
      [4, 3, 2, 2, 6, 7, 4, 6, 5, 5, 5, 3, 3],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 102 for test input" do
      expect(problem1(processed_input)).to eq(102)
    end
  end

  describe "problem2" do
    let(:another_input) do
      %(111111111111
999999999991
999999999991
999999999991
999999999991)
    end

    it "returns 94 for test input" do
      expect(problem2(processed_input)).to eq(94)
    end

    it "returns 71 for another input" do
      expect(problem2(process_input(another_input))).to eq(71)
    end
  end
end
