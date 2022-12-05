# frozen_string_literal: true

require_relative "../../../2022/05/lib"

RSpec.describe Year2022::Day05 do
  include described_class

  let(:input) do
    %(
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
)
  end
  let(:processed_input) do
    {
      stacks: [
        %w[Z N],
        %w[M C D],
        %w[P],
      ],
      procedure: [
        { amount: 1, from: 1, to: 0 },
        { amount: 3, from: 0, to: 2 },
        { amount: 2, from: 1, to: 0 },
        { amount: 1, from: 0, to: 1 },
      ],
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 'CMZ' for test input" do
      expect(problem1(processed_input)).to eq("CMZ")
    end
  end

  describe "problem2" do
    it "returns 'MCD' for test input" do
      expect(problem2(processed_input)).to eq("MCD")
    end
  end
end
