# frozen_string_literal: true

require_relative "../../../2022/16/lib"

RSpec.describe Year2022::Day16 do
  include described_class

  let(:input) do
    %(Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II
)
  end
  let(:processed_input) do
    {
      "AA" => { rate: 0, valves: %w[DD II BB] },
      "BB" => { rate: 13, valves: %w[CC AA] },
      "CC" => { rate: 2, valves: %w[DD BB] },
      "DD" => { rate: 20, valves: %w[CC AA EE] },
      "EE" => { rate: 3, valves: %w[FF DD] },
      "FF" => { rate: 0, valves: %w[EE GG] },
      "GG" => { rate: 0, valves: %w[FF HH] },
      "HH" => { rate: 22, valves: %w[GG] },
      "II" => { rate: 0, valves: %w[AA JJ] },
      "JJ" => { rate: 21, valves: %w[II] },
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 1651 for test input" do
      expect(problem1(processed_input)).to eq(1651)
    end
  end

  describe "problem2" do
    it "returns 1707 for test input" do
      expect(problem2(processed_input)).to eq(1707)
    end
  end
end
