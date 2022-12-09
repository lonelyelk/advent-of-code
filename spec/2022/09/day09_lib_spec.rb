# frozen_string_literal: true

require_relative "../../../2022/09/lib"

RSpec.describe Year2022::Day09 do
  include described_class

  let(:input) do
    %(R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
)
  end
  let(:processed_input) do
    [
      [?R, 4],
      [?U, 4],
      [?L, 3],
      [?D, 1],
      [?R, 4],
      [?D, 1],
      [?L, 5],
      [?R, 2],
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
    it "returns nil for test input" do
      expect(problem2([[?R, 5], [?U, 8], [?L, 8], [?D, 3], [?R, 17], [?D, 10], [?L, 25], [?U, 20]])).to eq(36)
    end
  end
end
