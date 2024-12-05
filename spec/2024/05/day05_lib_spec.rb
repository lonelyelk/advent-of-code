# frozen_string_literal: true

require_relative "../../../2024/05/lib"

RSpec.describe Year2024::Day05 do
  include described_class

  let(:input) do
    %(47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
)
  end
  let(:processed_input) do
    {
      order: %w[
        47|53
        97|13
        97|61
        97|47
        75|29
        61|13
        75|53
        29|13
        97|29
        53|29
        61|53
        97|53
        61|29
        47|13
        75|47
        97|75
        47|61
        75|61
        47|29
        75|13
        53|13
      ],
      instructions: [
        %w[75 47 61 53 29],
        %w[97 61 53 29 13],
        %w[75 29 13],
        %w[75 97 47 61 53],
        %w[61 13 29],
        %w[97 13 75 29 47],
      ],
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 143 for test input" do
      expect(problem1(processed_input)).to eq(143)
    end
  end

  describe "problem2" do
    it "returns 123 for test input" do
      expect(problem2(processed_input)).to eq(123)
    end
  end
end
