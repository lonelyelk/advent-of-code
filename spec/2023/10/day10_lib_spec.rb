# frozen_string_literal: true

require_relative "../../../2023/10/lib"

RSpec.describe Year2023::Day10 do
  include described_class

  let(:input) do
    %(-L|F7
7S-7|
L|7||
-L-J|
L|-JF
)
  end
  let(:processed_input) do
    [
      "-L|F7",
      "7S-7|",
      "L|7||",
      "-L-J|",
      "L|-JF",
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    let(:another_input) do
      [
        "7-F7-",
        ".FJ|7",
        "SJLL7",
        "|F--J",
        "LJ.LJ",
      ]
    end
    it "returns 4 for test input" do
      expect(problem1(processed_input)).to eq(4)
    end

    it "returns 8 for another input" do
      expect(problem1(another_input)).to eq(8)
    end
  end

  describe "problem2" do
    it "returns nil for test input" do
      expect(problem2(processed_input)).to eq(nil)
    end
  end
end
