# frozen_string_literal: true

require_relative "../../../2021/03/lib"

RSpec.describe Day03 do
  include described_class

  let(:input) do
    %(
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
)
  end
  let(:processed_input) do
    %w[
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    context "with gamma rate" do
      it "returns 22 for test input" do
        expect(gamma_rate(processed_input)).to eq(22)
      end
    end

    it "returns nil for test input" do
      expect(problem1(processed_input)).to eq(198)
    end
  end

  describe "problem2" do
    context "with oxygen rate" do
      it "returns 23 for test input" do
        expect(oxygen_rate(processed_input)).to eq(23)
      end
    end

    context "with co2 rate" do
      it "returns 10 for test input" do
        expect(co2_rate(processed_input)).to eq(10)
      end
    end

    it "returns 230 for test input" do
      expect(problem2(processed_input)).to eq(230)
    end
  end
end
