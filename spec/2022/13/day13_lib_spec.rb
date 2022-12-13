# frozen_string_literal: true

require_relative "../../../2022/13/lib"

RSpec.describe Year2022::Day13 do
  include described_class

  let(:input) do
    %([1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
)
  end
  let(:processed_input) do
    [
      [
        [1, 1, 3, 1, 1],
        [1, 1, 5, 1, 1],
      ],
      [
        [[1], [2, 3, 4]],
        [[1], 4],
      ],
      [
        [9],
        [[8, 7, 6]],
      ],
      [
        [[4, 4], 4, 4],
        [[4, 4], 4, 4, 4],
      ],
      [
        [7, 7, 7, 7],
        [7, 7, 7],
      ],
      [
        [],
        [3],
      ],
      [
        [[[]]],
        [[]],
      ],
      [
        [1, [2, [3, [4, [5, 6, 7]]]], 8, 9],
        [1, [2, [3, [4, [5, 6, 0]]]], 8, 9],
      ],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 13 for test input" do
      expect(problem1(processed_input)).to eq(13)
    end
  end

  describe "problem2" do
    it "returns 140 for test input" do
      expect(problem2(processed_input)).to eq(140)
    end
  end
end
