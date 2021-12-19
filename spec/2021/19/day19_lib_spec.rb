# frozen_string_literal: true

require_relative "../../../2021/19/lib"

RSpec.describe Day19 do
  include described_class

  let(:input) do
    File.read(File.join(__dir__, "input.txt"))
  end
  let(:processed_input) do
    nil
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input).size).to eq(5)
    end

    it "parses all measurements inside" do
      expect(process_input(input).map(&:size)).to eq([25, 25, 26, 25, 26])
    end

    it "parses all coordinates inside" do
      expect(process_input(input).map { |s| s.map(&:size) }.flatten).to all(eq(3))
    end
  end

  xdescribe "problem12" do
    it "returns 79 and 3621 for test input for problem 1 and 2" do
      expect(problem12(process_input(input))).to eq([79, 3621])
    end
  end

  describe "rotation_matrices" do
    it "finds all 24 rotation matrices" do
      expect(rotation_matrices.size).to eq(24)
    end
  end
end
