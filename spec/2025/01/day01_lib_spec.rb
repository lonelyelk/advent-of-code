# frozen_string_literal: true

require_relative "../../../2025/01/lib"

RSpec.describe Year2025::Day01 do
  include described_class

  let(:input) do
    %(L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
)
  end
  let(:processed_input) do
    %w[
      L68
      L30
      R48
      L5
      R60
      L55
      L1
      L99
      R14
      L82
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns nil for test input" do
      expect(problem1(processed_input)).to eq(3)
    end
  end

  describe "problem2" do
    it "returns nil for test input" do
      expect(problem2(processed_input)).to eq(6)
    end
  end
end
