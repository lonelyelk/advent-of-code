# frozen_string_literal: true

require_relative "../../../2021/14/lib"

RSpec.describe Day14 do
  include described_class

  let(:input) do
    %(NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
)
  end
  let(:processed_input) do
    [
      "NNCB",
      {
        "CH" => "B",
        "HH" => "N",
        "CB" => "H",
        "NH" => "C",
        "HB" => "C",
        "HC" => "B",
        "HN" => "C",
        "NN" => "C",
        "BH" => "H",
        "NC" => "B",
        "NB" => "B",
        "BN" => "B",
        "BB" => "N",
        "BC" => "B",
        "CC" => "N",
        "CN" => "C",
      },
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 1588 for test input" do
      expect(problem1(processed_input)).to eq(1588)
    end
  end

  describe "problem2" do
    it "returns 2_188_189_693_529 for test input" do
      expect(problem2(processed_input)).to eq(2_188_189_693_529)
    end
  end
end
