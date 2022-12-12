# frozen_string_literal: true

require_relative "../../../2022/12/lib"

RSpec.describe Year2022::Day12 do
  include described_class

  let(:input) do
    %(Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
)
  end
  let(:processed_input) do
    {
      start: [0, 0],
      end: [5, 2],
      field: [
        %w[a a b q p o n m],
        %w[a b c r y x x l],
        %w[a c c s z z x k],
        %w[a c c t u v w j],
        %w[a b d e f g h i],
      ],
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 31 for test input" do
      expect(problem1(processed_input)).to eq(31)
    end
  end

  describe "problem2" do
    it "returns 29 for test input" do
      expect(problem2(processed_input)).to eq(29)
    end
  end
end
