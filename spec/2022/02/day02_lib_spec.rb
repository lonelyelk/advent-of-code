# frozen_string_literal: true

require_relative "../../../2022/02/lib"

RSpec.describe Year2022::Day02 do
  include described_class

  let(:input) do
    %(
A Y
B X
C Z
)
  end
  let(:processed_input) do
    [
      %w[A Y],
      %w[B X],
      %w[C Z],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 15 for test input" do
      expect(problem1(processed_input)).to eq(15)
    end
  end

  describe "problem2" do
    it "returns 12 for test input" do
      expect(problem2(processed_input)).to eq(12)
    end
  end
end
