# frozen_string_literal: true

require_relative "../../../2025/06/lib"

RSpec.describe Year2025::Day06 do
  include described_class

  let(:input) do
    [
      "123 328  51 64 ",
      " 45 64  387 23 ",
      "  6 98  215 314",
      "*   +   *   +  ",
    ].join("\n")
  end
  let(:processed_input) do
    [
      "123 328  51 64 ",
      " 45 64  387 23 ",
      "  6 98  215 314",
      "*   +   *   +  ",
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 4_277_556 for test input" do
      expect(problem1(processed_input)).to eq(4_277_556)
    end
  end

  describe "problem2" do
    it "returns 3_263_827 for test input" do
      expect(problem2(processed_input)).to eq(3_263_827)
    end
  end
end
