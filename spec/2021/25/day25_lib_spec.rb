# frozen_string_literal: true

require_relative "../../../2021/25/lib"

RSpec.describe Day25 do
  include described_class

  let(:input) do
    %(v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>
)
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to match(a_hash_including(:east, :south))
    end

    it "places sea cucumbers facing east corretly" do
      expect(process_input(input)[:east].size).to eq(23)
    end

    it "places sea cucumbers facing south corretly" do
      expect(process_input(input)[:south].size).to eq(26)
    end
  end

  describe "problem1" do
    it "returns 58 for test input" do
      expect(problem1(process_input(input))).to eq(58)
    end
  end
end
