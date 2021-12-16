# frozen_string_literal: true

require_relative "../../../2021/16/lib"

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
    it "returns nil for test input" do
      expect(problem1(process_input("8A004A801A8002F478"))).to eq(16)
      expect(problem1(process_input("620080001611562C8802118E34"))).to eq(12)
      expect(problem1(process_input("C0015000016115A2E0802F182340"))).to eq(23)
      expect(problem1(process_input("A0016C880162017C3686B18A3D4780"))).to eq(31)
    end
  end

  describe "problem2" do
    it "returns nil for test input" do
      expect(problem2(process_input("C200B40A82"))).to eq(3)
      expect(problem2(process_input("04005AC33890"))).to eq(54)
      expect(problem2(process_input("880086C3E88112"))).to eq(7)
      expect(problem2(process_input("CE00C43D881120"))).to eq(9)
      expect(problem2(process_input("D8005AC2A8F0"))).to eq(1)
      expect(problem2(process_input("F600BC2D8F"))).to eq(0)
      expect(problem2(process_input("9C005AC2F8F0"))).to eq(0)
      expect(problem2(process_input("9C0141080250320F1802104A08"))).to eq(1)
    end
  end
end
