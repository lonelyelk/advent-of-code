# frozen_string_literal: true

require_relative "../../../2021/20/lib"

RSpec.describe Day20 do
  include described_class

  let(:input) do
    "..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..##" \
    "#..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###" \
    ".######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#." \
    ".#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#....." \
    ".#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.." \
    "...####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#....." \
    "..##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#" \
    "\n\n" +
      %(#..#.
#....
##..#
..#..
..###
)
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input).size).to eq(2)
    end

    it "converts picture to a hash" do
      expect(process_input(input)[1]).to be_a(Hash)
    end
  end

  describe "problem1" do
    it "returns 35 for test input" do
      expect(problem1(process_input(input))).to eq(35)
    end
  end

  describe "problem2" do
    it "returns 3351 for test input" do
      expect(problem2(process_input(input))).to eq(3351)
    end
  end
end
