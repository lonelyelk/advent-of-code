# frozen_string_literal: true

require_relative "../../../2022/06/lib"

RSpec.describe Year2022::Day06 do
  include described_class

  let(:input) do
    %(mjqjpqmgbljsphdztnvjfqwrcgsmlb
)
  end
  let(:processed_input) do
    "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 7 for test input" do
      expect(problem1(processed_input)).to eq(7)
    end
  end

  describe "problem2" do
    it "returns 19 for test input" do
      expect(problem2("mjqjpqmgbljsphdztnvjfqwrcgsmlb")).to eq(19)
    end
  end
end
