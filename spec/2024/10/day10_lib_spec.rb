# frozen_string_literal: true

require_relative "../../../2024/10/lib"

RSpec.describe Year2024::Day10 do
  include described_class

  let(:input) do
    %(89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
)
  end

  describe "problem1" do
    it "returns 36 for test input" do
      expect(problem1(process_input(input))).to eq(36)
    end
  end

  describe "problem2" do
    it "returns 81 for test input" do
      expect(problem2(process_input(input))).to eq(81)
    end
  end
end
