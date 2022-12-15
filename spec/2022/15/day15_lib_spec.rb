# frozen_string_literal: true

require_relative "../../../2022/15/lib"

RSpec.describe Year2022::Day15 do
  include described_class

  let(:input) do
    %(Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3
)
  end
  let(:processed_input) do
    [
      { sensor: [2, 18], beacon: [-2, 15] },
      { sensor: [9, 16], beacon: [10, 16] },
      { sensor: [13, 2], beacon: [15, 3] },
      { sensor: [12, 14], beacon: [10, 16] },
      { sensor: [10, 20], beacon: [10, 16] },
      { sensor: [14, 17], beacon: [10, 16] },
      { sensor: [8, 7], beacon: [2, 10] },
      { sensor: [2, 0], beacon: [2, 10] },
      { sensor: [0, 11], beacon: [2, 10] },
      { sensor: [20, 14], beacon: [25, 17] },
      { sensor: [17, 20], beacon: [21, 22] },
      { sensor: [16, 7], beacon: [15, 3] },
      { sensor: [14, 3], beacon: [15, 3] },
      { sensor: [20, 1], beacon: [15, 3] },
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 26 for test input" do
      expect(problem1(processed_input, 10)).to eq(26)
    end
  end

  describe "problem2" do
    it "returns 56000011 for test input" do
      expect(problem2(processed_input, 20)).to eq(56000011)
    end
  end
end
