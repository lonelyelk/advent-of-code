# frozen_string_literal: true

require_relative "../../../2022/02/lib"

RSpec.describe Year2022::Day02 do
  include described_class

  let(:input) do
    %(
)
  end
  let(:processed_input) do
    nil
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns nil for test input" do
      expect(problem1(processed_input)).to eq(nil)
    end
  end

  describe "problem2" do
    it "returns nil for test input" do
      expect(problem2(processed_input)).to eq(nil)
    end
  end
end
