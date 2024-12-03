# frozen_string_literal: true

require_relative "../../../2024/03/lib"

RSpec.describe Year2024::Day03 do
  include described_class

  let(:input) do
    "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
  end
  let(:processed_input) do
    "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 161 for test input" do
      expect(problem1(processed_input)).to eq(161)
    end
  end

  describe "problem2" do
    it "returns 48 for another input input" do
      expect(problem2("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")).to eq(48)
    end
  end
end
