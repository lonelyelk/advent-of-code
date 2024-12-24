# frozen_string_literal: true

require_relative "../../../2024/24/lib"

RSpec.describe Year2024::Day24 do
  include described_class

  let(:input) do
    %(x00: 1
x01: 1
x02: 1
y00: 0
y01: 1
y02: 0

x00 AND y00 -> z00
x01 XOR y01 -> z01
x02 OR y02 -> z02
)
  end
  let(:processed_input) do
    {
      state: {
        "x00" => 1,
        "x01" => 1,
        "x02" => 1,
        "y00" => 0,
        "y01" => 1,
        "y02" => 0,
      },
      operations: [
        %w[AND x00 y00 z00],
        %w[XOR x01 y01 z01],
        %w[OR x02 y02 z02],
      ],
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 4 for test input" do
      expect(problem1(processed_input)).to eq(4)
    end
  end
end
