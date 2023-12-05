# frozen_string_literal: true

require_relative "../../../2023/05/lib"

RSpec.describe Year2023::Day05 do
  include described_class

  let(:input) do
    %(seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
)
  end
  let(:processed_input) do
    nil
  end

  xdescribe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 35 for test input" do
      expect(problem1(process_input(input))).to eq(35)
    end
  end

  describe "problem2" do
    it "returns 46 for test input" do
      expect(problem2(process_input(input))).to eq(46)
    end
  end
end
