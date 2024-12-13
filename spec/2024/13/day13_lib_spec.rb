# frozen_string_literal: true

require_relative "../../../2024/13/lib"

RSpec.describe Year2024::Day13 do
  include described_class

  let(:input) do
    %(Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279
)
  end
  let(:processed_input) do
    [
      [
        Matrix[[94, 22], [34, 67]],
        Matrix[[8400], [5400]],
      ],
      [
        Matrix[[26, 67], [66, 21]],
        Matrix[[12_748], [12_176]],
      ],
      [
        Matrix[[17, 84], [86, 37]],
        Matrix[[7870], [6450]],
      ],
      [
        Matrix[[69, 27], [23, 71]],
        Matrix[[18_641], [10_279]],
      ],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 480 for test input" do
      expect(problem1(processed_input)).to eq(480)
    end
  end
end
