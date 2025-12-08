# frozen_string_literal: true

require_relative "../../../2025/08/lib"

RSpec.describe Year2025::Day08 do
  include described_class

  let(:input) do
    %(162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689
)
  end
  let(:processed_input) do
    [
      [162, 817, 812],
      [57, 618, 57],
      [906, 360, 560],
      [592, 479, 940],
      [352, 342, 300],
      [466, 668, 158],
      [542, 29, 236],
      [431, 825, 988],
      [739, 650, 466],
      [52, 470, 668],
      [216, 146, 977],
      [819, 987, 18],
      [117, 168, 530],
      [805, 96, 715],
      [346, 949, 466],
      [970, 615, 88],
      [941, 993, 340],
      [862, 61, 35],
      [984, 92, 344],
      [425, 690, 689],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 40 for test input" do
      expect(problem1(processed_input, 10)).to eq(40)
    end
  end

  describe "problem2" do
    it "returns 25_272 for test input" do
      expect(problem2(processed_input)).to eq(25_272)
    end
  end
end
