# frozen_string_literal: true

require_relative "../../../2022/24/lib"

RSpec.describe Year2022::Day24 do
  include described_class

  let(:input) do
    %(#.######
#>>.<^<#
#.<..<<#
#>v.><>#
#<^v^^>#
######.#
)
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input).size).to eq(12)
    end
  end

  describe "problem1" do
    it "returns 18 for test input" do
      expect(problem1(process_input(input))).to eq(18)
    end
  end

  describe "problem2" do
    it "returns 54 for test input" do
      expect(problem2(process_input(input))).to eq(54)
    end
  end
end
