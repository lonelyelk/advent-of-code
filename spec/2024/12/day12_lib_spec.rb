# frozen_string_literal: true

require_relative "../../../2024/12/lib"

RSpec.describe Year2024::Day12 do
  include described_class

  let(:input) do
    %(AAAA
BBCD
BBCC
EEEC
)
  end
  let(:processed_input) do
    %w[
      ......
      .AAAA.
      .BBCD.
      .BBCC.
      .EEEC.
      ......
    ]
  end
  let(:input_ones) do
    %(OOOOO
OXOXO
OOOOO
OXOXO
OOOOO
)
  end
  let(:input_e) do
    %(EEEEE
EXXXX
EEEEE
EXXXX
EEEEE
)
  end
  let(:input_big) do
    %(RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
)
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 140 for test input" do
      expect(problem1(processed_input)).to eq(140)
    end

    it "returns 772 for input_ones" do
      expect(problem1(process_input(input_ones))).to eq(772)
    end

    it "returns 1930 for input_big" do
      expect(problem1(process_input(input_big))).to eq(1930)
    end
  end

  describe "problem2" do
    it "returns 80 for test input" do
      expect(problem2(processed_input)).to eq(80)
    end

    it "returns 236 for input_e" do
      expect(problem2(process_input(input_e))).to eq(236)
    end

    it "returns 436 for input_ones" do
      expect(problem2(process_input(input_ones))).to eq(436)
    end

    it "returns 1206 for input_big" do
      expect(problem2(process_input(input_big))).to eq(1206)
    end
  end
end
