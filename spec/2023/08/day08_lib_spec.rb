# frozen_string_literal: true

require_relative "../../../2023/08/lib"

RSpec.describe Year2023::Day08 do
  include described_class

  let(:input) do
    %(RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)
)
  end
  let(:processed_input) do
    {
      instructions: "RL",
      map: {
        "AAA" => %w[BBB CCC],
        "BBB" => %w[DDD EEE],
        "CCC" => %w[ZZZ GGG],
        "DDD" => %w[DDD DDD],
        "EEE" => %w[EEE EEE],
        "GGG" => %w[GGG GGG],
        "ZZZ" => %w[ZZZ ZZZ],
      },
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    let(:another_input) do
      {
        instructions: "LLR",
        map: { "AAA" => %w[BBB BBB], "BBB" => %w[AAA ZZZ], "ZZZ" => %w[ZZZ ZZZ] },
      }
    end

    it "returns 2 for test input" do
      expect(problem1(processed_input)).to eq(2)
    end

    it "returns 6 for another input input" do
      expect(problem1(another_input)).to eq(6)
    end
  end

  describe "problem2" do
    let(:ghost_input) do
      {
        instructions: "LR",
        map: {
          "11A" => %w[11B XXX],
          "11B" => %w[XXX 11Z],
          "11Z" => %w[11B XXX],
          "22A" => %w[22B XXX],
          "22B" => %w[22C 22C],
          "22C" => %w[22Z 22Z],
          "22Z" => %w[22B 22B],
          "XXX" => %w[XXX XXX],
        },
      }
    end

    it "returns 6 for test input" do
      expect(problem2(ghost_input)).to eq(6)
    end
  end
end
