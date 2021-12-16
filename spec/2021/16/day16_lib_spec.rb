# frozen_string_literal: true

require_relative "../../../2021/16/lib"

TEST_CASES_PROBLEM1 = {
  "8A004A801A8002F478" => 16,
  "620080001611562C8802118E34" => 12,
  "C0015000016115A2E0802F182340" => 23,
  "A0016C880162017C3686B18A3D4780" => 31,
}.freeze

TEST_CASES_PROBLEM2 = {
  "C200B40A82" => 3,
  "04005AC33890" => 54,
  "880086C3E88112" => 7,
  "CE00C43D881120" => 9,
  "D8005AC2A8F0" => 1,
  "F600BC2D8F" => 0,
  "9C005AC2F8F0" => 0,
  "9C0141080250320F1802104A08" => 1,
}.freeze

RSpec.describe Day16 do
  include described_class

  let(:input) do
    %(D2FE28
)
  end
  let(:processed_input) do
    "110100101111111000101000"
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    TEST_CASES_PROBLEM1.each do |input, expected|
      it "returns #{expected} for test input '#{input}'" do
        expect(problem1(process_input(input))).to eq(expected)
      end
    end
  end

  describe "problem2" do
    TEST_CASES_PROBLEM2.each do |input, expected|
      it "returns #{expected} for test input '#{input}'" do
        expect(problem2(process_input(input))).to eq(expected)
      end
    end
  end
end
