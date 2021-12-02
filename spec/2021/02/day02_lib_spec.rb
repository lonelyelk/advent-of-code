# frozen_string_literal: true

require_relative "../../../2021/02/lib"

RSpec.describe Day02 do
  include described_class

  let(:input) do
    %(
forward 5
down 5
forward 8
up 3
down 8
forward 2
)
  end
  let(:processed_input) do
    [
      ["forward", 5],
      ["down", 5],
      ["forward", 8],
      ["up", 3],
      ["down", 8],
      ["forward", 2],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns an array of commands" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 150 for test input" do
      expect(problem1(processed_input)).to eq(150)
    end
  end

  describe "problem2" do
    it "returns 900 for test input" do
      expect(problem2(processed_input)).to eq(900)
    end
  end
end
