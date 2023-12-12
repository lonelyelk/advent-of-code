# frozen_string_literal: true

require_relative "../../../2023/12/lib"

RSpec.describe Year2023::Day12 do
  include described_class

  let(:input) do
    %(???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1
)
  end
  let(:processed_input) do
    [
      ["???.###", [1, 1, 3]],
      [".??..??...?##.", [1, 1, 3]],
      ["?#?#?#?#?#?#?#?", [1, 3, 1, 6]],
      ["????.#...#...", [4, 1, 1]],
      ["????.######..#####.", [1, 6, 5]],
      ["?###????????", [3, 2, 1]],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 21 for test input" do
      expect(problem1(processed_input)).to eq(21)
    end
  end

  describe "problem2" do
    it "returns 525152 for test input" do
      expect(problem2(processed_input)).to eq(525_152)
    end
  end
end
