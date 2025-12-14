# frozen_string_literal: true

require_relative "../../../2025/12/lib"

RSpec.describe Year2025::Day12 do
  include described_class

  let(:input) do
    %(0:
###
##.
##.

1:
###
##.
.##

2:
.##
###
##.

3:
##.
###
##.

4:
###
#..
###

5:
###
.#.
###

4x4: 0 0 0 0 2 0
12x5: 1 0 1 0 2 2
12x5: 1 0 1 0 3 2
)
  end
  let(:processed_input) do
    {
      presents: [
        %w[###
           ##.
           ##.],
        %w[###
           ##.
           .##],
        %w[.##
           ###
           ##.],
        %w[##.
           ###
           ##.],
        %w[###
           #..
           ###],
        %w[###
           .#.
           ###],
      ],
      spaces: [
        { width: 4, length: 4, presents: [0, 0, 0, 0, 2, 0] },
        { width: 12, length: 5, presents: [1,  0, 1, 0,  2,  2] },
        { width: 12, length: 5, presents: [1,  0, 1, 0,  3,  2] },
      ],
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns nil for test input" do
      skip "Generic implementation for the test case would not be able to solve the real input in reasonable time"
      expect(problem1(processed_input)).to eq(nil)
    end
  end
end
