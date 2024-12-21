# frozen_string_literal: true

require_relative "../../../2024/21/lib"

RSpec.describe Year2024::Day21 do
  include described_class

  let(:input) do
    %(029A
980A
179A
456A
379A
)
  end
  let(:processed_input) do
    %w[
      029A
      980A
      179A
      456A
      379A
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 126384 for test input" do
      expect(problem1(processed_input)).to eq(126_384)
    end
  end
end
