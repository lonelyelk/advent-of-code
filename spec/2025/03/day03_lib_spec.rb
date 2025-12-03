# frozen_string_literal: true

require_relative "../../../2025/03/lib"

RSpec.describe Year2025::Day03 do
  include described_class

  let(:input) do
    %(987654321111111
811111111111119
234234234234278
818181911112111
)
  end
  let(:processed_input) do
    %w[
      987654321111111
      811111111111119
      234234234234278
      818181911112111
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 357 for test input" do
      expect(problem1(processed_input)).to eq(357)
    end
  end

  describe "problem2" do
    it "returns 3_121_910_778_619 for test input" do
      expect(problem2(processed_input)).to eq(3_121_910_778_619)
    end
  end
end
