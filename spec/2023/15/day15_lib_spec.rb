# frozen_string_literal: true

require_relative "../../../2023/15/lib"

RSpec.describe Year2023::Day15 do
  include described_class

  let(:input) do
    %(rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
)
  end
  let(:processed_input) do
    %w[rn=1 cm- qp=3 cm=2 qp- pc=4 ot=9 ab=5 pc- pc=6 ot=7]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 1320 for test input" do
      expect(problem1(processed_input)).to eq(1320)
    end
  end

  describe "problem2" do
    it "returns 145 for test input" do
      expect(problem2(processed_input)).to eq(145)
    end
  end
end
