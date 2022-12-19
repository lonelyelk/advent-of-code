# frozen_string_literal: true

require_relative "../../../2022/19/lib"

RSpec.describe Year2022::Day19 do
  include described_class

  let(:input) do
    %(Blueprint 1:
  Each ore robot costs 4 ore.
  Each clay robot costs 2 ore.
  Each obsidian robot costs 3 ore and 14 clay.
  Each geode robot costs 2 ore and 7 obsidian.

Blueprint 2:
  Each ore robot costs 2 ore.
  Each clay robot costs 3 ore.
  Each obsidian robot costs 3 ore and 8 clay.
  Each geode robot costs 3 ore and 12 obsidian.
)
  end
  let(:processed_input) do
    [
      [[4], [2], [3, 14], [2, 0, 7]],
      [[2], [3], [3, 8], [3, 0, 12]],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 33 for test input" do
      expect(problem1(processed_input)).to eq(33)
    end
  end

  describe "problem2" do
    it "returns nil for test input" do
      expect(problem2(processed_input)).to eq(nil)
    end
  end
end
