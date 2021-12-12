# frozen_string_literal: true

require_relative "../../../2021/12/lib"

RSpec.describe Day12 do
  include described_class

  let(:input) do
    %(
start-A
start-b
A-c
A-b
b-d
A-end
b-end
)
  end
  let(:processed_input) do
    {
      "A" => ["start", "c", "b", "end"],
      "b" => ["start", "A", "d", "end"],
      "c" => ["A"],
      "d" => ["b"],
      "end" => ["A", "b"],
      "start" => ["A", "b"],
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 10 for test input" do
      expect(problem1(processed_input)).to eq(10)
    end
  end

  describe "problem2" do
    it "returns 36 for test input" do
      expect(problem2(processed_input)).to eq(36)
    end
  end
end
